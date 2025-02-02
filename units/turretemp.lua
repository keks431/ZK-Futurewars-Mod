return { 
	turretemp = {
		unitname                      = [[turretemp]],
		name                          = [[Pulse]],
		description                   = [[EMP Turret]],
		buildCostMetal                = 275,
		builder                       = false,
		buildingGroundDecalDecaySpeed = 30,
		buildingGroundDecalSizeX      = 4,
		buildingGroundDecalSizeY      = 4,
		buildingGroundDecalType       = [[turretemp_aoplane.dds]],
		buildPic                      = [[turretemp.png]],
		category                      = [[SINK TURRET]],
		collisionVolumeOffsets        = [[0 0 0]],
		collisionVolumeScales         = [[32 75 32]],
		collisionVolumeType           = [[CylY]],
		corpse                        = [[DEAD]],
		customParams                  = {
			bait_level_default = 1,
			bait_level_target_armor = 1,
			aimposoffset   = [[0 10 0]],
			modelradius    = [[16]],
			aim_lookahead  = 50,
			popupholdfirehp = 0.45,
			popupunholdfirehp = 0.66,
		},
		damageModifier                = 0.2,
		explodeAs                     = [[MEDIUM_BUILDINGEX]],
		footprintX                    = 2,
		footprintZ                    = 2,
		iconType                      = [[defensespecial]],
		levelGround                   = false,
		maxDamage                     = 2200,
		maxSlope                      = 36,
		maxWaterDepth                 = 0,
		noChaseCategory               = [[FIXEDWING LAND SHIP SWIM GUNSHIP SUB HOVER]],
		objectName                    = [[armartic.s3o]],
		script                        = [[turretemp.lua]],
		selfDestructAs                = [[MEDIUM_BUILDINGEX]],
		sfxtypes                      = {
			explosiongenerators = {
				[[custom:zeus_fire_fx]],
				[[custom:YELLOW_LIGHTNING_GROUNDFLASH]],
			},
		},
		sightDistance                 = 554, -- Range*1.1 + 48 for radar overshoot
		useBuildingGroundDecal        = true,
		yardMap                       = [[oo oo]],
		weapons                       = {
			{
				def                = [[arm_det_weapon]],
				onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER FIXEDWING GUNSHIP]],
			},
		},
		weaponDefs                    = {
			arm_det_weapon = {
				name                    = [[Light EMP Bolter]],
				areaOfEffect            = 120,
				cegtag					= [[artillery_spark_small_commander]],
				craterBoost             = 0,
				craterMult              = 0,
				customParams            = {
					light_camera_height = 1600,
					light_color = [[0.85 0.85 1.2]],
					light_radius = 200,
					extra_damage = 1100,
				},
				damage                  = {
					default = 37.1*3,
				},
				cylinderTargeting       = 1,
				explosionGenerator      = [[custom:hammer_artillery_hit]],
				edgeEffectiveness       = 0.05,
				paralyzeTime            = 1,
				impactOnly              = false,
				interceptedByShieldType = 1,
				range					= 500,
				myGravity               = 0.02,
				reloadtime              = 1.8,
				soundHit                = [[weapon/cannon/emp_arty_hit]],
				soundStart              = [[weapon/emp/commweapon_emplight_fire]],
				size					= 0.01,
				turret                  = true,
				weaponType              = [[Cannon]],
				weaponVelocity          = 700,
			},
		},
		featureDefs                   = {
			DEAD  = {
				blocking         = true,
				featureDead      = [[HEAP]],
				footprintX       = 2,
				footprintZ       = 2,
				object           = [[armartic_dead.s3o]],
			},
			HEAP  = {
				blocking         = false,
				footprintX       = 2,
				footprintZ       = 2,
				object           = [[debris3x3b.s3o]],
			},
		},
	}
}
