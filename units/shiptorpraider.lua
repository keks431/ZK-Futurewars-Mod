return { 
	shiptorpraider = {
		unitname            = [[shiptorpraider]],
		name                = [[Swell]],
		description         = [[Anti-Sub Skirmisher]],
		acceleration        = 0.24,
		activateWhenBuilt   = true,
		brakeRate           = 0.43,
		buildCostMetal      = 125,
		builder             = false,
		buildPic            = [[shiptorpraider.png]],
		canGuard            = true,
		canMove             = true,
		canPatrol           = true,
		category            = [[SHIP]],
		collisionVolumeOffsets = [[0 0 0]],
		collisionVolumeScales  = [[28 28 55]],
		collisionVolumeType    = [[cylZ]],
		corpse              = [[DEAD]],

		customParams        = {
			modelradius        = [[14]],
			turnatfullspeed    = [[1]],
			aim_lookahead      = 120,
		},

		explodeAs           = [[SMALL_UNITEX]],
		floater             = true,
		footprintX          = 3,
		footprintZ          = 3,
		iconType            = [[shiptorpraider]],
		idleAutoHeal        = 5,
		idleTime            = 1800,
		maneuverleashlength = [[1280]],
		maxDamage           = 850,
		maxVelocity         = 2.5,
		minWaterDepth       = 5,
		movementClass       = [[BOAT3]],
		noAutoFire          = false,
		noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE HOVER]],
		objectName          = [[shiptorpraider.dae]],
		script              = [[shiptorpraider.lua]],
		selfDestructAs      = [[SMALL_UNITEX]],
		sightDistance       = 650,
		sonarDistance       = 650,
		turnRate            = 400,
		waterline           = 0,
		workerTime          = 0,

		weapons             = {

			{
				def                = [[TORPEDO]],
				badTargetCategory  = [[FIXEDWING]],
				onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK TURRET FLOAT SHIP GUNSHIP HOVER]],
			},

		},

		weaponDefs          = {
			TORPEDO = {
				name                    = [[Torpedo]],
				areaOfEffect            = 80,
				avoidFriendly           = false,
				burst					= 3,
				burstrate				= 0.4,
				canAttackGround         = false, -- workaround for range hax
				collideFriendly         = false,
				craterBoost             = 0,
				craterMult              = 0,
				cegTag                  = [[torpedo_trail]],

				customParams = {
					burst = Shared.BURST_RELIABLE,
					cruisealt = -15,
					cruisetracking = 1,
					cruise_nolock = 1,
					cruisedist = 140,
				},

				damage                  = {
					default = 100.1,
				},

				edgeEffectiveness       = 0.6,
				explosionGenerator      = [[custom:TORPEDO_HIT]],
				fixedLauncher           = true,
				impulseBoost            = 0,
				impulseFactor           = 0,
				interceptedByShieldType = 1,
				flightTime              = 6.4,
				leadlimit               = 200,
				model                   = [[wep_t_barracuda.s3o]],
				myGravity               = 3.57,
				noSelfDamage            = true,
				range                   = 520,
				reloadtime              = 2.5,
				soundHit                = [[weapon/torpedo/torpedohit_light]],
				soundHitVolume          = 2.8,
				soundStart              = [[weapon/missile/air_launched_missile]],
				soundStartVolume        = 4,
				startVelocity           = 120,
				tolerance               = 100000,
				tracks                  = true,
				turnRate                = 40000,
				turret                  = true,
				waterWeapon             = true,
				weaponAcceleration      = 240,
				weaponType              = [[TorpedoLauncher]],
				weaponVelocity          = 700,
			},
		},

		featureDefs         = {

			DEAD  = {
				blocking         = false,
				featureDead      = [[HEAP]],

				footprintX       = 2,
				footprintZ       = 2,
				object           = [[shiptorpraider_dead.dae]],
			},
			HEAP  = {
				blocking         = false,
				footprintX       = 2,
				footprintZ       = 2,
				object           = [[debris2x2c.s3o]],
			},
		},
	} 
}
