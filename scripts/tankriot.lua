include "constants.lua"
include "rockPiece.lua"
include "trackControl.lua"
include "pieceControl.lua"
local dynamicRockData

local scriptReload = include("scriptReload.lua")

local base, turret, sleeve = piece ('base', 'turret', 'sleeve')

local firepoint1 = piece('dummy1')
local firepoint2 = piece('dummy2')

local gun = {
	[0] = {firepoint = firepoint1, loaded = true},
	[1] = {firepoint = firepoint1, loaded = true},
	[2] = {firepoint = firepoint2, loaded = true},
	[3] = {firepoint = firepoint2, loaded = true},
}

local gameSpeed = Game.gameSpeed

local SIG_AIM = 1
local SIG_MOVE = 2
local SIG_ROCK_X = 4
local SIG_ROCK_Z = 8
local loaded = 4

local ROCK_FIRE_FORCE = 0.06
local ROCK_SPEED = 18 --Number of half-cycles per second around x-axis.
local ROCK_DECAY = -0.25 --Rocking around axis is reduced by this factor each time = piece 'to rock.
local ROCK_PIECE = base -- should be negative to alternate rocking direction.
local ROCK_MIN = 0.001 --If around axis rock is not greater than this amount, rocking will stop after returning to center.
local ROCK_MAX = 1.5

local hpi = math.pi*0.5
local SleepAndUpdateReload = scriptReload.SleepAndUpdateReload

local rockData = {
	[x_axis] = {
		piece = ROCK_PIECE,
		speed = ROCK_SPEED,
		decay = ROCK_DECAY,
		minPos = ROCK_MIN,
		maxPos = ROCK_MAX,
		signal = SIG_ROCK_X,
		axis = x_axis,
	},
	[z_axis] = {
		piece = ROCK_PIECE,
		speed = ROCK_SPEED,
		decay = ROCK_DECAY,
		minPos = ROCK_MIN,
		maxPos = ROCK_MAX,
		signal = SIG_ROCK_Z,
		axis = z_axis,
	},
}

local trackData = {
	wheels = {
		large = {piece('wheels1'), piece('wheels8')},
		small = {},
	},
	tracks = {},
	signal = SIG_MOVE,
	smallSpeed = math.rad(540),
	smallAccel = math.rad(15),
	smallDecel = math.rad(45),
	largeSpeed = math.rad(360),
	largeAccel = math.rad(10),
	largeDecel = math.rad(30),
	trackPeriod = 66,
}

for i = 2, 7 do
	trackData.wheels.small[i-1] = piece('wheels' .. i)
end
for i = 1, 4 do
	trackData.tracks[i] = piece ('tracks' .. i)
end

local gunHeading = 0

local disarmed = false
local stuns = {false, false, false}
local isAiming = false
local shot = 0
local smokePiece = {base, turret}
local gameSpeed = Game.gameSpeed
local RELOAD_TIME = 4.4 * gameSpeed

local function RestoreAfterDelay()
	SetSignalMask (SIG_AIM)

	Sleep (5000)

	Turn (turret, y_axis, 0, math.rad (50))
	Turn (sleeve, x_axis, 0, math.rad (50))

	WaitForTurn (turret, y_axis)
	WaitForTurn (sleeve, x_axis)
	isAiming = false
end

function StunThread()
	disarmed = true
	Signal (SIG_AIM)
	GG.PieceControl.StopTurn(turret, y_axis)
	GG.PieceControl.StopTurn(sleeve, x_axis)
end

function UnstunThread()
	disarmed = false
	if isAiming then
		StartThread(RestoreAfterDelay)
	end
end

function Stunned(stun_type)
	-- since only the turret is animated, treat all types the same since they all disable weaponry
	stuns[stun_type] = true
	StartThread (StunThread)
end

function Unstunned(stun_type)
	stuns[stun_type] = false
	if not stuns[1] and not stuns[2] and not stuns[3] then
		StartThread (UnstunThread)
	end
end

function script.StartMoving()
	StartThread(TrackControlStartMoving)
end

function script.StopMoving()
	TrackControlStopMoving()
end

function script.AimFromWeapon()
	return sleeve
end

function script.QueryWeapon()
	return gun[shot].firepoint
end

function script.AimWeapon(num, heading, pitch)
	Signal (SIG_AIM)
	SetSignalMask (SIG_AIM)

	isAiming = true

	while disarmed do
		Sleep (34)
	end
	--Spring.Echo("Loaded " .. shot .. ": " .. tostring(gun[shot].loaded))
	local slowMult = (Spring.GetUnitRulesParam (unitID, "baseSpeedMult") or 1)
	Turn (turret, y_axis, heading, math.rad(200)*slowMult)
	Turn (sleeve, x_axis, -pitch, math.rad(200)*slowMult)

	WaitForTurn (turret, y_axis)
	WaitForTurn (sleeve, x_axis)
	StartThread (RestoreAfterDelay)

	gunHeading = heading

	return true
end



local function reload(num)
	scriptReload.GunStartReload(num)
	gun[num].loaded = false
	SleepAndUpdateReload(num, 6 * 30)
	gun[num].loaded = true
	if scriptReload.GunLoaded(num) then
		shot = 0
	end
	loaded = loaded + 1
end

local function ReloadThread(missile)
	if missile%2 == 1 then
		Hide (gun[missile].firepoint)
		Move (gun[missile].firepoint, z_axis, -5)
		Sleep (1000)
		Show (gun[missile].firepoint)
		Move (gun[missile].firepoint, z_axis, 0.8, 5.5)
	else
		Move(gun[missile].firepoint, z_axis, -5)
		Move(gun[missile].firepoint, z_axis, 2.8, 5.5)
	end
end

function script.Shot(num)
	if num == 1 then
		--EmitSfx(gun[shot].firepoint, GG.Script.UNIT_SFX1)
		--StartThread(reload, shot)
		StartThread(ReloadThread, shot)
		StartThread(GG.ScriptRock.Rock, dynamicRockData[z_axis], gunHeading, ROCK_FIRE_FORCE)
		StartThread(GG.ScriptRock.Rock, dynamicRockData[x_axis], gunHeading - hpi, ROCK_FIRE_FORCE)
		StartThread(reload, shot)
		shot = (shot + 1)%4
	end
end

function script.BlockShot(num, targetID)
	if not gun[shot].loaded then
		return true
	end
	if not targetID then
		return false
	end
	local distMult = (Spring.GetUnitSeparation(unitID, targetID) or 0) * 0.083
	return GG.OverkillPrevention_CheckBlock(unitID, targetID, 181.2, distMult)
end

function script.Create()
	scriptReload.SetupScriptReload(4, RELOAD_TIME)
	dynamicRockData = GG.ScriptRock.InitializeRock(rockData)
	InitiailizeTrackControl(trackData)
	while (select(5, Spring.GetUnitHealth(unitID)) < 1) do
		Sleep (250)
	end

	Move(firepoint1, z_axis, 0.8)
	Move(firepoint2, z_axis, 0.8)

	StartThread (GG.Script.SmokeUnit, unitID, smokePiece)
end

function script.Killed (recentDamage, maxHealth)
	local severity = recentDamage / maxHealth
	if (severity < 0.5) then
		if (math.random() < 2*severity) then Explode (firepoint1, SFX.FALL + SFX.FIRE) end
		if (math.random() < 2*severity) then Explode (firepoint2, SFX.FALL + SFX.SMOKE) end
		return 1
	elseif (severity < 0.75) then
		if (math.random() < severity) then
			Explode (turret, SFX.FALL)
		end
		Explode(sleeve, SFX.FALL)
		Explode(trackData.tracks[1], SFX.SHATTER)
		Explode(firepoint1, SFX.FALL + SFX.SMOKE)
		Explode(firepoint2, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		return 2
	else
		Explode(base, SFX.SHATTER)
		Explode(turret, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		Explode(sleeve, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		Explode(trackData.tracks[1], SFX.SHATTER)
		Explode(firepoint1, SFX.FALL + SFX.SMOKE)
		Explode(firepoint2, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		return 2
	end
end
