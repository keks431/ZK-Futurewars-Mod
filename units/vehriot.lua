return { 
	vehriot = {
		unitname            = [[vehriot]],
		name                = [[Striker]],
		description         = [[Riot Rover]],
		acceleration        = 0.159,
		brakeRate           = 1.24,
		buildCostMetal      = 230,
		builder             = false,
		buildPic            = [[vehriot.png]],
		canGuard            = true,
		canMove             = true,
		canPatrol           = true,
		category            = [[LAND]],
		selectionVolumeOffsets = [[0 0 0]],
		selectionVolumeScales  = [[42 42 42]],
		selectionVolumeType    = [[ellipsoid]],
		corpse              = [[DEAD]],
		customParams        = {
			selection_scale   = 0.85,
			aim_lookahead     = 100,
			outline_x = 80,
			outline_y = 80,
			outline_yoff = 12.5,
		},
		explodeAs           = [[BIG_UNITEX]],
		footprintX          = 3,
		footprintZ          = 3,
		iconType            = [[vehicleriot]],
		idleAutoHeal        = 5,
		idleTime            = 1800,
		leaveTracks         = true,
		maxDamage           = 1100,
		maxSlope            = 18,
		maxVelocity         = 2.8,
		maxWaterDepth       = 22,
		movementClass       = [[TANK3]],
		noAutoFire          = false,
		noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
		objectName          = [[corleveler_512.s3o]],
		script              = [[vehriot.lua]],
		selfDestructAs      = [[BIG_UNITEX]],
		sfxtypes            = {
			explosiongenerators = {
				[[custom:RAIDMUZZLE]],
				[[custom:LEVLRMUZZLE_CLOUDLESS]],
				[[custom:RIOT_SHELL_L]],
			},
		},
		sightDistance       = 350,
		trackOffset         = 7,
		trackStrength       = 6,
		trackStretch        = 1,
		trackType           = [[StdTank]],
		trackWidth          = 28,
		turninplace         = 0,
		turnRate            = 624,
		weapons             = {
			{
				def                = [[vehriot_WEAPON]],
				badTargetCategory  = [[FIXEDWING]],
				onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
			},
		},
		weaponDefs          = {
			secondary = {
				name                    = [[Impulse Shard]],
				accuracy                = 350,
				alphaDecay              = 0.7,
				areaOfEffect            = 96,
				burnblow                = true,
				craterBoost             = 0.15,
				craterMult              = 0.3,
				customParams        = {
					gatherradius = [[90]],
					smoothradius = [[60]],
					smoothmult   = [[0.08]],
					light_camera_height = 1600,
					light_color = [[0.8 0.76 0.38]],
					light_radius = 40,
					isFlak = 2,
				},
				damage                  = {
					default = 40,
				},
				edgeEffectiveness       = 0.5,
				explosionGenerator      = [[custom:EMG_HIT_HE]],
				firestarter             = 70,
				impulseBoost            = 0,
				impulseFactor           = 0.4,
				intensity               = 0.7,
				interceptedByShieldType = 1,
				noSelfDamage            = true,
				range                   = 275,
				reloadtime              = 0.5,
				rgbColor                = [[1 0.95 0.4]],
				separation              = 1.5,
				soundHit                = [[weapon/cannon/emg_hit]],
				soundStart              = [[weapon/heavy_emg]],
				stages                  = 10,
				turret                  = true,
				weaponType              = [[Cannon]],
				weaponVelocity          = 550,
			},
			
			vehriot_WEAPON = {
				name                    = [[Impulse Cannon]],
				areaOfEffect            = 0,
				avoidFeature            = true,
				avoidFriendly           = true,
				burnblow                = true,
				craterBoost             = 1,
				craterMult              = 0.5,

				customParams            = {
					gatherradius = [[90]],
					smoothradius = [[60]],
					smoothmult   = [[0.08]],
					force_ignore_ground = [[1]],
					numprojectiles1 = 14, -- how many of the weapondef we spawn. OPTIONAL. Default: 1.
					projectile1 = "vehriot_secondary",
					--spreadradius1 = 4, -- used in clusters. OPTIONAL. Default: 100.
					clustervec1 = "randomxyz", -- accepted values: randomx, randomy, randomz, randomxy, randomxz, randomyz, random. OPTIONAL. default: random.
					use2ddist = 0, -- should we check 2d or 3d distance? OPTIONAL. Default: 0.
					spawndist = 120, -- at what distance should we spawn the projectile(s)? REQUIRED.
					timeoutspawn = 1, -- Can this missile spawn its subprojectiles when it times out? OPTIONAL. Default: 1.
					vradius1 = "-6,-2,-6,6,0,6", -- velocity that is randomly added. covers range of +-vradius. OPTIONAL. Default: 4.2
					groundimpact = 1, -- check the distance between ground and projectile? OPTIONAL.
					proxy = 0, -- check for nearby units?
					proxydist = 100, -- how far to check for units? Default: spawndist
					reaim_time = 60, -- Fast update not required (maybe dangerous)
					light_camera_height = 1500,
					light_color = [[0.8 0.76 0.38]],
					light_radius = 40,
				},
				damage                  = {
					default = 40*14,
				},
				edgeEffectiveness       = 0.75,
				explosionGenerator      = [[custom:FLASH64]],
				impulseBoost            = 30,
				impulseFactor           = 0.6,
				interceptedByShieldType = 1,
				noSelfDamage            = true,
				range                   = 280,
				reloadtime              = 1.6,
				soundHit                = [[weapon/clusters/cluster_light]],
				soundStart              = [[weapon/cannon/outlaw_gun]],
				soundStartVolume        = 3,
				turret                  = true,
				weaponType              = [[Cannon]],
				weaponVelocity          = 550,
			},
		},
		
		
		featureDefs         = {
			
			DEAD  = {
				blocking         = true,
				featureDead      = [[HEAP]],
				footprintX       = 2,
				footprintZ       = 2,
				object           = [[leveler_d.dae]],
			},

			HEAP  = {
				blocking         = false,
				footprintX       = 2,
				footprintZ       = 2,
				object           = [[debris2x2a.s3o]],
			},

		},
	}
}
