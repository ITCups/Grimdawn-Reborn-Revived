/*
	
	GRIM DAWN	SURVIVAL MODE
	scripts/game/questevents.lua
	
	For more information, visit us at http://www.grimdawn.com
	
*/

--
-- Event dispatch tables
--

clientQuestTable = 	{	 
						-- Global events here (no server check here or in the dispatch function)
						eventFinished = gd.survival.eventControl.eventFinishedGlobalMP,
						eventFailed = gd.survival.eventControl.eventFailedGlobalMP,
						activateEvent = gd.survival.eventControl.activateEventGlobalMP,
						deactivateEvent = gd.survival.eventControl.deactivateEventGlobalMP,
						tier05ProgressToken = gd.survival.rewards.tier05TokenGlobalMP,
						tier10ProgressToken = gd.survival.rewards.tier10TokenGlobalMP,
						completeProgressToken = gd.survival.rewards.completeTokenGlobalMP,
						playerExperience = gd.survival.rewards.playerExperienceGlobalMP,
						playerTierExperience = gd.survival.rewards.playerTierExperienceGlobalMP,
						playerTributes = gd.survival.rewards.playerTributesGlobalMP,
						playerTierTributes = gd.survival.rewards.playerTierTributesGlobalMP,
						screenGlow = gd.survival.rewards.screenGlowGlobalMP,
						notifyMutators = gd.survival.eventControl.notifyMutatorsGlobalMP,
						notifyPluralMutators = gd.survival.eventControl.notifyMutatorsPluralGlobalMP,
						updateRewardTier = gd.survival.eventControl.updateRewardTierGlobalMP,
						defenseBuiltToken = gd.survival.rewards.defenseBuiltTokenGlobalMP,
						powerUp01Active = gd.survival.rewards.powerUp01ActiveTokenGlobalMP,
						powerUp02Active = gd.survival.rewards.powerUp02ActiveTokenGlobalMP,
						powerUp03Active = gd.survival.rewards.powerUp03ActiveTokenGlobalMP,
						powerUp04Active = gd.survival.rewards.powerUp04ActiveTokenGlobalMP,
						eventResetGlobalMP = gd.survival.eventControl.resetEventGlobalMP,
						eventRestartGlobalMP = gd.survival.eventControl.restartEventGlobalMP,
						bonusChestTokenGlobalMP = gd.survival.rewards.bonusChestTokenGlobalMP,
						playerTierRewards = gd.survival.rewards.resetPlayerTierRewardsGlobalMP,
						checkPoint50UsedGlobalMP = gd.survival.rewards.checkpoint50UsedGlobalMP,
						checkPoint100UsedGlobalMP = gd.survival.rewards.checkpoint100UsedGlobalMP,
						restartUsedGlobalMP = gd.survival.rewards.restartUsedGlobalMP,
						resetRestartVariableGlobalMP = gd.survival.rewards.resetRestartVariableGlobalMP,
						resetRewardVariablesGlobalMP = gd.survival.rewards.resetVariablesGlobalMP,
						
						
					};

serverQuestTable = 	{
						-- Server-run events here (server check here and in the dispatch function for good measure)
						startEvent = gd.survival.eventControl.startSurvivalModeEvent,
						startTier05Event = gd.survival.eventControl.startTier05Event,
						startTier10Event = gd.survival.eventControl.startTier10Event,
						
						startTier01 = gd.survival.tier01Waves.startSurvivalModeEvent,
						startTier02 = gd.survival.tier02Waves.startSurvivalModeEvent,
						startTier03 = gd.survival.tier03Waves.startSurvivalModeEvent,
						startTier04 = gd.survival.tier04Waves.startSurvivalModeEvent,
						startTier05 = gd.survival.tier05Waves.startSurvivalModeEvent,
						startTier06 = gd.survival.tier06Waves.startSurvivalModeEvent,
						startTier07 = gd.survival.tier07Waves.startSurvivalModeEvent,
						startTier08 = gd.survival.tier08Waves.startSurvivalModeEvent,
						startTier09 = gd.survival.tier09Waves.startSurvivalModeEvent,
						startTier10 = gd.survival.tier10Waves.startSurvivalModeEvent,
						startTier11 = gd.survival.tier11Waves.startSurvivalModeEvent,
						startTier12 = gd.survival.tier12Waves.startSurvivalModeEvent,
						startTier13 = gd.survival.tier13Waves.startSurvivalModeEvent,
						startTier14 = gd.survival.tier14Waves.startSurvivalModeEvent,
						startTier15 = gd.survival.tier15Waves.startSurvivalModeEvent,
						
						endEvent = gd.survival.eventControl.eventFinishedCashOut,
						upgradeReward = gd.survival.rewards.upgradeRewards,
						bonusChest = gd.survival.rewards.bonusChest,
						
						eventReset = gd.survival.eventControl.resetEvent,
						eventRestart = gd.survival.eventControl.restartEvent,
						
						--Server-run events for spawning Defense objects
						spawnDefensePoint01_BannerDefense = gd.survival.defenses.setDefensePoint01_BannerDefense,
						spawnDefensePoint01_BannerOffense = gd.survival.defenses.setDefensePoint01_BannerOffense,
						spawnDefensePoint01_TurretFire = gd.survival.defenses.setDefensePoint01_TurretFire,
						spawnDefensePoint01_TurretIce = gd.survival.defenses.setDefensePoint01_TurretIce,
						spawnDefensePoint01_TurretLightning = gd.survival.defenses.setDefensePoint01_TurretLightning,
						spawnDefensePoint01_Wall = gd.survival.defenses.setDefensePoint01_Wall,
						
						spawnDefensePoint02_BannerDefense = gd.survival.defenses.setDefensePoint02_BannerDefense,
						spawnDefensePoint02_BannerOffense = gd.survival.defenses.setDefensePoint02_BannerOffense,
						spawnDefensePoint02_TurretFire = gd.survival.defenses.setDefensePoint02_TurretFire,
						spawnDefensePoint02_TurretIce = gd.survival.defenses.setDefensePoint02_TurretIce,
						spawnDefensePoint02_TurretLightning = gd.survival.defenses.setDefensePoint02_TurretLightning,
						spawnDefensePoint02_Wall = gd.survival.defenses.setDefensePoint02_Wall,
						
						spawnDefensePoint03_BannerDefense = gd.survival.defenses.setDefensePoint03_BannerDefense,
						spawnDefensePoint03_BannerOffense = gd.survival.defenses.setDefensePoint03_BannerOffense,
						spawnDefensePoint03_TurretFire = gd.survival.defenses.setDefensePoint03_TurretFire,
						spawnDefensePoint03_TurretIce = gd.survival.defenses.setDefensePoint03_TurretIce,
						spawnDefensePoint03_TurretLightning = gd.survival.defenses.setDefensePoint03_TurretLightning,
						spawnDefensePoint03_Wall = gd.survival.defenses.setDefensePoint03_Wall,
						
						spawnDefensePoint04_BannerDefense = gd.survival.defenses.setDefensePoint04_BannerDefense,
						spawnDefensePoint04_BannerOffense = gd.survival.defenses.setDefensePoint04_BannerOffense,
						spawnDefensePoint04_TurretFire = gd.survival.defenses.setDefensePoint04_TurretFire,
						spawnDefensePoint04_TurretIce = gd.survival.defenses.setDefensePoint04_TurretIce,
						spawnDefensePoint04_TurretLightning = gd.survival.defenses.setDefensePoint04_TurretLightning,
						spawnDefensePoint04_Wall = gd.survival.defenses.setDefensePoint04_Wall,
						
						upgrade_DefensePoint01 = gd.survival.defenses.upgradeDefensePoint01,
						upgrade_DefensePoint02 = gd.survival.defenses.upgradeDefensePoint02,
						upgrade_DefensePoint03 = gd.survival.defenses.upgradeDefensePoint03,
						upgrade_DefensePoint04 = gd.survival.defenses.upgradeDefensePoint04,

						
					};
					