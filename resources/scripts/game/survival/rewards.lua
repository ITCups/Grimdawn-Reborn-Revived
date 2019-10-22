/*
	
	GRIM DAWN SURVIVAL MODE
	
	For more information, visit us at http://www.grimdawn.com
	
*/

gd.survival.rewards = {}

--
-- Dispense rewards at the end of the Survival Mode event
-- up to 5 chests are dispensed based on which stopping point the players achieve
-- Reward Tiers occur every 10 waves, up to 20 tiers
--
local rewardDispensed = false
local rewardUpgraded = false
local bonusChest = false
local checkpoint50Used = false
local checkpoint100Used = false
local restartUsed = false
local restartWaveNumber = 0

local rewardDoorId = 0
local bonusChestId = 0
local bonusChest02Id = 0

local rewardChestIds = {0, 0, 0, 0, 0}
local rewardChestEntities = {nil, nil, nil, nil, nil, nil, nil}

-- Reward Table by Reward Tier with # of Entries equal to # of Chests
-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local rewardTable = { }
rewardTable[0] = { "records/items/lootchests/survivalchest_b01.dbr", nil, "records/items/lootchests/survivalchest_b01.dbr", nil, "records/items/lootchests/survivalchest_b01.dbr" }
rewardTable[1] = { "records/items/lootchests/survivalchest_c01.dbr", "records/items/lootchests/survivalchest_a01.dbr", "records/items/lootchests/survivalchest_d01.dbr", "records/items/lootchests/survivalchest_a01.dbr", "records/items/lootchests/survivalchest_c01.dbr" }
rewardTable[2] = { "records/items/lootchests/survivalchest_c01.dbr", "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_c01.dbr" }
rewardTable[3] = { "records/items/lootchests/survivalchest_d01.dbr", "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_d01.dbr" }
rewardTable[4] = { "records/items/lootchests/survivalchest_d01.dbr", "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_d01.dbr" }
rewardTable[5] = { "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_e01.dbr" }
rewardTable[6] = { "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_f01.dbr" }
rewardTable[7] = { "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_f01.dbr" }
rewardTable[8] = { "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_g01.dbr" }
rewardTable[9] = { "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_g01.dbr" }
rewardTable[10] = { "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_h01.dbr" }

rewardTable[11] = { "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_h01.dbr" }
rewardTable[12] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
rewardTable[13] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
rewardTable[14] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }
rewardTable[15] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }

rewardTable[16] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
rewardTable[17] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
rewardTable[18] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
rewardTable[19] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
rewardTable[20] = { "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr" }

-- Reward Table for Compensation for when players failed to reach the next Reward Tier, with # of Entries equal to # of Chests
-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local compensationTable = { }
compensationTable[0] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
compensationTable[1] = { "records/items/lootchests/survivalchest_c01.dbr", "records/items/lootchests/survivalchest_a01.dbr", nil, "records/items/lootchests/survivalchest_a01.dbr", "records/items/lootchests/survivalchest_c01.dbr" }
compensationTable[2] = { "records/items/lootchests/survivalchest_c01.dbr", "records/items/lootchests/survivalchest_e01.dbr", nil, "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_c01.dbr" }
compensationTable[3] = { "records/items/lootchests/survivalchest_d01.dbr", "records/items/lootchests/survivalchest_e01.dbr", nil, "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_d01.dbr" }
compensationTable[4] = { "records/items/lootchests/survivalchest_d01.dbr", "records/items/lootchests/survivalchest_f01.dbr", nil, "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_d01.dbr" }
compensationTable[5] = { "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_f01.dbr", nil, "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_e01.dbr" }
compensationTable[6] = { "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_g01.dbr", nil, "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_f01.dbr" }
compensationTable[7] = { "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_h01.dbr", nil, "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_f01.dbr" }
compensationTable[8] = { "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_h01.dbr", nil, "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_g01.dbr" }
compensationTable[9] = { "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_i01.dbr", nil, "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_g01.dbr" }
compensationTable[10] = { "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_i01.dbr", nil, "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_h01.dbr" }

compensationTable[11] = { "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_j01.dbr", nil, "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_h01.dbr" }
compensationTable[12] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_j01.dbr", nil, "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
compensationTable[13] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_k01.dbr", nil, "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
compensationTable[14] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_l01.dbr", nil, "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }
compensationTable[15] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }

compensationTable[16] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_l01.dbr", nil, "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
compensationTable[17] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
compensationTable[18] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
compensationTable[19] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_n01.dbr", nil, "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
compensationTable[20] = { "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", nil, "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr" }

-- Reward Table for Checkpoint for when players restart at Wave 50 and failed to reach the next Reward Tier, with # of Entries equal to # of Chests
-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local checkpoint50Table = { }
checkpoint50Table[0] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint50Table[1] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint50Table[2] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint50Table[3] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint50Table[4] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint50Table[5] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint50Table[6] = { "records/items/lootchests/survivalchest_c01.dbr", "records/items/lootchests/survivalchest_e01.dbr", nil, "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_c01.dbr" }
checkpoint50Table[7] = { "records/items/lootchests/survivalchest_f01.dbr", "records/items/lootchests/survivalchest_h01.dbr", nil, "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_f01.dbr" }
checkpoint50Table[8] = { "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_h01.dbr", nil, "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_g01.dbr" }
checkpoint50Table[9] = { "records/items/lootchests/survivalchest_g01.dbr", "records/items/lootchests/survivalchest_i01.dbr", nil, "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_g01.dbr" }
checkpoint50Table[10] = { "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_i01.dbr", nil, "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_h01.dbr" }

checkpoint50Table[11] = { "records/items/lootchests/survivalchest_h01.dbr", "records/items/lootchests/survivalchest_i01.dbr", nil, "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_h01.dbr" }
checkpoint50Table[12] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_j01.dbr", nil, "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
checkpoint50Table[13] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_k01.dbr", nil, "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
checkpoint50Table[14] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_l01.dbr", nil, "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }
checkpoint50Table[15] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }

checkpoint50Table[16] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_l01.dbr", nil, "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
checkpoint50Table[17] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
checkpoint50Table[18] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
checkpoint50Table[19] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_n01.dbr", nil, "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
checkpoint50Table[20] = { "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", nil, "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr" }

-- Reward Table for Checkpoint for when players restart at Wave 100 and failed to reach the next Reward Tier, with # of Entries equal to # of Chests
-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local checkpoint100Table = { }
checkpoint100Table[0] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint100Table[1] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint100Table[2] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint100Table[3] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint100Table[4] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint100Table[5] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
checkpoint100Table[6] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
checkpoint100Table[7] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
checkpoint100Table[8] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
checkpoint100Table[9] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
checkpoint100Table[10] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }

checkpoint100Table[11] = { "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_e01.dbr", nil, "records/items/lootchests/survivalchest_e01.dbr", "records/items/lootchests/survivalchest_e01.dbr" }
checkpoint100Table[12] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_j01.dbr", nil, "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
checkpoint100Table[13] = { "records/items/lootchests/survivalchest_i01.dbr", "records/items/lootchests/survivalchest_k01.dbr", nil, "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_i01.dbr" }
checkpoint100Table[14] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_l01.dbr", nil, "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }
checkpoint100Table[15] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_j01.dbr" }

checkpoint100Table[16] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_l01.dbr", nil, "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
checkpoint100Table[17] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
checkpoint100Table[18] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
checkpoint100Table[19] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_n01.dbr", nil, "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
checkpoint100Table[20] = { "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_n01.dbr", nil, "records/items/lootchests/survivalchest_n01.dbr", "records/items/lootchests/survivalchest_m01.dbr" }

-- Reward Table for Checkpoint for when players uses a restart above wave 100 and failed to reach the next Reward Tier, with # of Entries equal to # of Chests
-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local restartTable = { }
restartTable[0] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
restartTable[1] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
restartTable[2] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
restartTable[3] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
restartTable[4] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
restartTable[5] = { "records/items/lootchests/survivalchest_a01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_a01.dbr" }
restartTable[6] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
restartTable[7] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
restartTable[8] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
restartTable[9] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }
restartTable[10] = { "records/items/lootchests/survivalchest_b01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_b01.dbr" }

restartTable[11] = { "records/items/lootchests/survivalchest_c01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_c01.dbr" }
restartTable[12] = { "records/items/lootchests/survivalchest_c01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_c01.dbr" }
restartTable[13] = { "records/items/lootchests/survivalchest_c01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_c01.dbr" }
restartTable[14] = { "records/items/lootchests/survivalchest_d01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_d01.dbr" }
restartTable[15] = { "records/items/lootchests/survivalchest_d01.dbr", nil, nil, nil, "records/items/lootchests/survivalchest_d01.dbr" }

restartTable[16] = { "records/items/lootchests/survivalchest_j01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
restartTable[17] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_k01.dbr" }
restartTable[18] = { "records/items/lootchests/survivalchest_k01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
restartTable[19] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }
restartTable[20] = { "records/items/lootchests/survivalchest_l01.dbr", "records/items/lootchests/survivalchest_m01.dbr", nil, "records/items/lootchests/survivalchest_m01.dbr", "records/items/lootchests/survivalchest_l01.dbr" }



-- Bonus Table for players who opt to activate the 6th spawn point. Only activates if victorious.
-- Also used for the Score-based 7th chest, which appears regardless of success.
-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local bonusTable = { }
bonusTable[0] = "records/items/lootchests/survivalchest_a01.dbr"
bonusTable[1] = "records/items/lootchests/survivalchest_b01.dbr"
bonusTable[2] = "records/items/lootchests/survivalchest_c01.dbr"
bonusTable[3] = "records/items/lootchests/survivalchest_d01.dbr"
bonusTable[4] = "records/items/lootchests/survivalchest_e01.dbr"
bonusTable[5] = "records/items/lootchests/survivalchest_e01.dbr"
bonusTable[6] = "records/items/lootchests/survivalchest_f01.dbr"
bonusTable[7] = "records/items/lootchests/survivalchest_f01.dbr"
bonusTable[8] = "records/items/lootchests/survivalchest_g01.dbr"
bonusTable[9] = "records/items/lootchests/survivalchest_g01.dbr"
bonusTable[10] = "records/items/lootchests/survivalchest_h01.dbr"

bonusTable[11] = "records/items/lootchests/survivalchest_h01.dbr"
bonusTable[12] = "records/items/lootchests/survivalchest_i01.dbr"
bonusTable[13] = "records/items/lootchests/survivalchest_j01.dbr"
bonusTable[14] = "records/items/lootchests/survivalchest_k01.dbr"
bonusTable[15] = "records/items/lootchests/survivalchest_l01.dbr"

bonusTable[16] = "records/items/lootchests/survivalchest_m01.dbr"
bonusTable[17] = "records/items/lootchests/survivalchest_n01.dbr"
bonusTable[18] = "records/items/lootchests/survivalchest_n01.dbr"
bonusTable[19] = "records/items/lootchests/survivalchest_n01.dbr"
bonusTable[20] = "records/items/lootchests/survivalchest_n01.dbr"

-- Chests go from A to N, with incrementally better rewards, nil for when the chest location is unused
local checkpointBonusTable = { }
checkpointBonusTable[0] = "records/items/lootchests/survivalchest_a01.dbr"
checkpointBonusTable[1] = "records/items/lootchests/survivalchest_a01.dbr"
checkpointBonusTable[2] = "records/items/lootchests/survivalchest_b01.dbr"
checkpointBonusTable[3] = "records/items/lootchests/survivalchest_b01.dbr"
checkpointBonusTable[4] = "records/items/lootchests/survivalchest_c01.dbr"
checkpointBonusTable[5] = "records/items/lootchests/survivalchest_c01.dbr"
checkpointBonusTable[6] = "records/items/lootchests/survivalchest_d01.dbr"
checkpointBonusTable[7] = "records/items/lootchests/survivalchest_d01.dbr"
checkpointBonusTable[8] = "records/items/lootchests/survivalchest_e01.dbr"
checkpointBonusTable[9] = "records/items/lootchests/survivalchest_e01.dbr"
checkpointBonusTable[10] = "records/items/lootchests/survivalchest_f01.dbr"

checkpointBonusTable[11] = "records/items/lootchests/survivalchest_f01.dbr"
checkpointBonusTable[12] = "records/items/lootchests/survivalchest_g01.dbr"
checkpointBonusTable[13] = "records/items/lootchests/survivalchest_g01.dbr"
checkpointBonusTable[14] = "records/items/lootchests/survivalchest_j01.dbr"
checkpointBonusTable[15] = "records/items/lootchests/survivalchest_j01.dbr"

checkpointBonusTable[16] = "records/items/lootchests/survivalchest_k01.dbr"
checkpointBonusTable[17] = "records/items/lootchests/survivalchest_k01.dbr"
checkpointBonusTable[18] = "records/items/lootchests/survivalchest_l01.dbr"
checkpointBonusTable[19] = "records/items/lootchests/survivalchest_l01.dbr"
checkpointBonusTable[20] = "records/items/lootchests/survivalchest_m01.dbr"


function gd.survival.rewards.rewardChest01OnAddToWorld(objectId)

	if Server then
		rewardChestIds[1] = objectId
		
	end
	
end

function gd.survival.rewards.rewardChest02OnAddToWorld(objectId)

	if Server then
		rewardChestIds[2] = objectId
		
	end
	
end

function gd.survival.rewards.rewardChest03OnAddToWorld(objectId)

	if Server then
		rewardChestIds[3] = objectId
		
	end
	
end

function gd.survival.rewards.rewardChest04OnAddToWorld(objectId)

	if Server then
		rewardChestIds[4] = objectId
		
	end
	
end

function gd.survival.rewards.rewardChest05OnAddToWorld(objectId)

	if Server then
		rewardChestIds[5] = objectId
		
	end
	
end

function gd.survival.rewards.bonusChestOnAddToWorld(objectId)

	if Server then
		bonusChestId = objectId
		
	end
	
end

function gd.survival.rewards.bonusChest02OnAddToWorld(objectId)

	if Server then
		bonusChest02Id = objectId
		
	end
	
end


function gd.survival.rewards.rewardDoorOnAddToWorld(objectId)
	
	if Server then
		rewardDoorId = objectId
		
	end
	
end


-- Grant Xp to each player at the END of the event
function gd.survival.rewards.playerExperienceGlobalMP()

	local player = Game.GetLocalPlayer()
	local rewardTier = gd.survival.eventControl.checkRewardTier()
	local wave = Game.GetSurvivalWaveTier()
	local difficultyModifier = 0
	
	if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
		difficultyModifier = 1
	elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
		difficultyModifier = 1.3
	else
		difficultyModifier = 2.2
	end
	
	-- Experience gained based on wave reached.
	local xp = 0
	if wave == 1 then
		xp = difficultyModifier * 100
	elseif wave <= 5 then
		xp = difficultyModifier * ((wave * 40) ^ 1.33 + 500)
	else
		xp = difficultyModifier * ((wave * 40) ^ 1.33 + 700)
	end
		
	if restartUsed then
		xp = xp / 2
		
	elseif checkpoint50Used && (rewardTier <= 6) then
		xp = xp / 10
		
	elseif checkpoint50Used then
		xp = xp / 3
		
	elseif checkpoint100Used && (rewardTier <= 11) then
		xp = xp / 15
		
	elseif checkpoint100Used then
		xp = xp / 3
		
	end
	
	player:GiveExperience(xp)

end


-- Grant Xp to each player after each event Tier
function gd.survival.rewards.playerTierExperienceGlobalMP()

	local player = Game.GetLocalPlayer()
	local rewardTier = gd.survival.eventControl.checkRewardTier()
	local wave = Game.GetSurvivalWaveTier()
	local difficultyModifier = 0
	
	if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
		difficultyModifier = 1
	elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
		difficultyModifier = 1.3
	else
		difficultyModifier = 2.2
	end
	
	-- Experience gained based on wave reached.
	local xp = difficultyModifier * ((wave * 40) ^ 1.25 + 11)
	
	if restartUsed then
		xp = xp / 2
		
	elseif checkpoint50Used && (rewardTier <= 6) then
		xp = xp / 10
		
	elseif checkpoint50Used then
		xp = xp / 3
		
	elseif checkpoint100Used && (rewardTier <= 11) then
		xp = xp / 15
		
	elseif checkpoint100Used then
		xp = xp / 3
		
	end
	
	player:GiveExperience(xp)

end

-- Dispense Tributes and Iron Bits to each player and update Leaderboard, at the END of the event
function gd.survival.rewards.playerTributesGlobalMP()

	local player = Game.GetLocalPlayer()
	local rewardTier = gd.survival.eventControl.checkRewardTier()
	local eventFailed = gd.survival.eventControl.checkEventFailed()
	local difficultyModifier = 0
	
	if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
		difficultyModifier = 0.78
	elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
		difficultyModifier = 1.25
	else
		difficultyModifier = 1.5
	end

	-- calculate tributes awarded based on success, game difficulty and tier reached.
	local tributes = difficultyModifier * (((rewardTier * 0.29) ^ 2) + 2.6)
	
	if eventFailed then
		if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
			tributes = tributes / 2 - 0.1
		elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
			tributes = tributes / 2 - 0.8
		else
			tributes = tributes / 2 - 1.1
		end
		
		if checkpoint50Used || checkpoint100Used then
			tributes = tributes / 2
		end
		
	elseif restartUsed then
		if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
			tributes = tributes / 1.5 - 0.1
		elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
			tributes = tributes / 1.5 - 0.8
		else
			tributes = tributes / 1.5 - 1.1
		end
		
	elseif checkpoint50Used && (rewardTier <= 7) then
		if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
			tributes = tributes - 3
		elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
			tributes = tributes - 6
		else
			tributes = tributes - 7
		end
		
		
	elseif checkpoint100Used && (rewardTier <= 12) then
		if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
			tributes = tributes - 5
		elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
			tributes = tributes - 10
		else
			tributes = tributes - 12
		end
		
	end
	
	if tributes > 0 then
		player:AdjustTribute(tributes)
	
	end
	
	-- Save Score to Leaderboard
	Game.SaveSurvivalScore()

end

-- Dispense Tributes to each player after each tier
function gd.survival.rewards.playerTierTributesGlobalMP()

	local player = Game.GetLocalPlayer()
	local rewardTier = gd.survival.eventControl.checkRewardTier()
	local difficultyModifier = 0
	
	if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
		difficultyModifier = 1.2
	elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
		difficultyModifier = 1.8
	else
		difficultyModifier = 2.29
	end

	local tributes = difficultyModifier * (((rewardTier * 0.15) ^ 1) + 1.25)
	
	if restartUsed then
		if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
			tributes = tributes / 1.1 - 0.1
		elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
			tributes = tributes / 1.1 - 0.8
		else
			tributes = tributes / 1.1 - 1.1
		end
	end
	
	if tributes > 0 then
		player:AdjustTribute(tributes)
	
	end

end


-- End of Event Function. Dispenses Reward and Opens the Treasure Room Door
function gd.survival.rewards.dispenseReward()

	if Server && not rewardDispensed then
		rewardDispensed = true

		local eventFailed = gd.survival.eventControl.checkEventFailed()
		local rewardTier = gd.survival.eventControl.checkRewardTier()
		
		local player = Game.GetLocalPlayer()
		local score = player:GetSurvivalScore()
		local scoreBonus = math.floor(0.5 * ((score * 0.02) ^ 0.3) - 1)
		if scoreBonus > 20 then
			scoreBonus = 20
		end
		
		-- play treasure room sound
		Game.ClearObjectives()
		
		if eventFailed then
			Game.PlayNetSound("records/sounds/spak_eventfail.dbr")
			
			-- Update Objectives
			Game.AddObjective("tagNotification_Failure")
			Game.AddObjective("tagNotification_Reset")
			
		else
			Game.PlayNetSound("records/sounds/spak_treasureroom.dbr")
			
			-- Update Objectives
			Game.AddObjective("tagNotification_Reward")
			Game.AddObjective("tagNotification_Reset")
			
			-- if reward was upgraded and players cashed out, increase Reward Tier
			if rewardUpgraded then
				rewardTier = rewardTier + 2
			
			end
			
		end
		
		-- create chests
		local totalChests = table.getn(rewardChestIds)
		
		for id = 1, totalChests do
			local chest = Entity.Get(rewardChestIds[id])
			
			if chest != nil then
				local coords = chest:GetCoords()
				
				-- if the player reached the next treasure tier and opted to "cash out", they receive the earned rewards.
				if not eventFailed then
					if rewardTable[rewardTier][id] != nil then
						local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
						if (fx != nil) then
							fx:NetworkEnable()
							fx:SetCoords(coords)
						end
						
						rewardChestEntities[id] = Entity.Create(rewardTable[rewardTier][id])
						if rewardChestEntities[id] != nil then
							rewardChestEntities[id]:SetCoords(coords)
						end
						
					
					end
				
				-- if the player failed to reach the next treasure tier and used a checkpoint, then they are given the checkpoint loot
				elseif checkpoint50Used then
					if checkpoint50Table[rewardTier][id] != nil then
						local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
						if (fx != nil) then
							fx:NetworkEnable()
							fx:SetCoords(coords)
						end
						
						rewardChestEntities[id] = Entity.Create(checkpoint50Table[rewardTier][id])
						if rewardChestEntities[id] != nil then
							rewardChestEntities[id]:SetCoords(coords)
						end
					
					end
					
				-- if the player failed to reach the next treasure tier and used a checkpoint, then they are given the checkpoint loot
				elseif checkpoint100Used then
					if checkpoint100Table[rewardTier][id] != nil then
						local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
						if (fx != nil) then
							fx:NetworkEnable()
							fx:SetCoords(coords)
						end
						
						rewardChestEntities[id] = Entity.Create(checkpoint100Table[rewardTier][id])
						if rewardChestEntities[id] != nil then
							rewardChestEntities[id]:SetCoords(coords)
						end
					
					end
					
				-- if the player failed to reach the next treasure tier and used a restart above wave 100, then they are given the restart loot
				elseif restartUsed && (wave >= restartWaveNumber && wave < (restartWaveNumber + 3)) then
					if restartTable[rewardTier][id] != nil then
						local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
						if (fx != nil) then
							fx:NetworkEnable()
							fx:SetCoords(coords)
						end
						
						rewardChestEntities[id] = Entity.Create(restartTable[rewardTier][id])
						if rewardChestEntities[id] != nil then
							rewardChestEntities[id]:SetCoords(coords)
						end
					
					end
					
				-- if the player failed to reach the next treasure tier, then they are given the compensation loot
				else
					if compensationTable[rewardTier][id] != nil then
						local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
						if (fx != nil) then
							fx:NetworkEnable()
							fx:SetCoords(coords)
						end
						
						rewardChestEntities[id] = Entity.Create(compensationTable[rewardTier][id])
						if rewardChestEntities[id] != nil then
							rewardChestEntities[id]:SetCoords(coords)
						end
					
					end
				
				end
			
			end
		
		end
		
		-- Dispense 6th chest, but only if player succeeded
		if bonusChest && not eventFailed && bonusTable[rewardTier] != nil && checkpointBonusTable[rewardTier] != nil then
			local chest = Entity.Get(bonusChestId)
			local coords = chest:GetCoords()
			local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
			if (fx != nil) then
				fx:NetworkEnable()
				fx:SetCoords(coords)
			end
			
			if checkpoint50Used || checkpoint100Used then
				rewardChestEntities[6] = Entity.Create(checkpointBonusTable[rewardTier])
				if rewardChestEntities[6] != nil then
					rewardChestEntities[6]:SetCoords(coords)
				end
			else
				rewardChestEntities[6] = Entity.Create(bonusTable[rewardTier])
				if rewardChestEntities[6] != nil then
					rewardChestEntities[6]:SetCoords(coords)
				end
			end
		
		end
		
		-- Dispense 7th chest, based on player's score
		if scoreBonus > 0 && bonusTable[scoreBonus] != nil then
			local chest = Entity.Get(bonusChest02Id)
			local coords = chest:GetCoords()
			local fx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")
				
			if (fx != nil) then
				fx:NetworkEnable()
				fx:SetCoords(coords)
			end
			
			rewardChestEntities[7] = Entity.Create(bonusTable[scoreBonus])
			if rewardChestEntities[7] != nil then
				rewardChestEntities[7]:SetCoords(coords)
			end
		
		end
		
		-- Grant player exp based on tier reached
		LuaGlobalEvent("playerExperience")
		
		-- Grant player tributes based on tier reached and success, also updates Leaderboard for each player
		LuaGlobalEvent("playerTributes")
		
		-- Open gate
		local door = Door.Get(rewardDoorId)
	
		if door != nil then
			door:Open()
		end
	
	end

end

-- Bestow Token for defeating the entire event
function gd.survival.rewards.completeTokenGlobalMP()
	
	if (Game.GetGameDifficulty() == Game.Difficulty.Normal) then
		GiveTokenToLocalPlayer("SURVIVALMODE_NORMAL")
		
	elseif (Game.GetGameDifficulty() == Game.Difficulty.Epic) then
		GiveTokenToLocalPlayer("SURVIVALMODE_NORMAL")
		GiveTokenToLocalPlayer("SURVIVALMODE_CHALLENGER")
		
	else
		GiveTokenToLocalPlayer("SURVIVALMODE_NORMAL")
		GiveTokenToLocalPlayer("SURVIVALMODE_CHALLENGER")
		GiveTokenToLocalPlayer("SURVIVALMODE_GLADIATOR")
		
		local bonusSpawns = gd.survival.rewards.checkBonusStatus()
		
		if bonusSpawns then
			GiveTokenToLocalPlayer("SURVIVALMODE_GLADIATORBONUSSPAWNS")
		
		end
		
	end
	
end


-- Show Screen Glow for Succeeding at the Event
function gd.survival.rewards.screenGlowGlobalMP()
	
	Game.PlayFullscreenGlow()
	
end

-- Bestow Token for making it past Tier 05
function gd.survival.rewards.tier05TokenGlobalMP()
	
	local player = Game.GetLocalPlayer()
	
	if (player:HasToken("SURVIVALMODE_TIER05CHECKPOINT") == false) then
		GiveTokenToLocalPlayer("SURVIVALMODE_TIER05CHECKPOINT")
		UI.Notify("tagNotification_Checkpoint05")
	
	end
	
end

-- Bestow Token for making it past Tier 10
function gd.survival.rewards.tier10TokenGlobalMP()
	
	local player = Game.GetLocalPlayer()
	
	if (player:HasToken("SURVIVALMODE_TIER10CHECKPOINT") == false) then
		GiveTokenToLocalPlayer("SURVIVALMODE_TIER10CHECKPOINT")
		UI.Notify("tagNotification_Checkpoint10")
		
		-- Unlock next difficulty
		Game.UnlockNextSurvivalDifficulty()
	
	end
	
end

-- Bestow Token for building a defense structure, for Achievement purposes
function gd.survival.rewards.defenseBuiltTokenGlobalMP()
	
	GiveTokenToLocalPlayer("SURVIVALMODE_DEFENSEBUILT")
	Game.UnlockTutorial(62)
	
end

-- Bestow Tokens for activating a power-up, for Achievement purposes
local powerUps = {false, false, false, false}

local function powerUpAchievementTest()

	if powerUps[1] && powerUps[2] && powerUps[3] && powerUps[4] then
		GiveTokenToLocalPlayer("SURVIVALMODE_4POWERUPS")
	
	end

end

function gd.survival.rewards.powerUp01ActiveTokenGlobalMP()
	
	GiveTokenToLocalPlayer("SURVIVALMODE_POWERUPACTIVE")
	
	powerUps[1] = true
	
	powerUpAchievementTest()
	
end

function gd.survival.rewards.powerUp02ActiveTokenGlobalMP()
	
	GiveTokenToLocalPlayer("SURVIVALMODE_POWERUPACTIVE")
	
	powerUps[2] = true
	
	powerUpAchievementTest()
	
end

function gd.survival.rewards.powerUp03ActiveTokenGlobalMP()
	
	GiveTokenToLocalPlayer("SURVIVALMODE_POWERUPACTIVE")
	
	powerUps[3] = true
	
	powerUpAchievementTest()
	
end

function gd.survival.rewards.powerUp04ActiveTokenGlobalMP()
	
	GiveTokenToLocalPlayer("SURVIVALMODE_POWERUPACTIVE")
	
	powerUps[4] = true
	
	powerUpAchievementTest()
	
end

-- Upgrade Reward Tier if players chose to invest Currency at the beginning of the event, but only if they succeed.
function gd.survival.rewards.upgradeRewards()
	
	rewardUpgraded = true
	
end

-- Unlock the 6th Bonus Chest if players choose to unlock the 6th spawn point, but only if they succeed.
local spawnPoint06FxId = 0

function gd.survival.rewards.spawnPoint06FXOnAddToWorld(objectId)

	if Server then
		spawnPoint06FxId = objectId
	
	end

end

function gd.survival.rewards.checkBonusStatus()

	return bonusChest

end

function gd.survival.rewards.bonusChestTokenGlobalMP()

	bonusChest = true
	
end

function gd.survival.rewards.bonusChest()

	if Server && not bonusChest then
		LuaGlobalEvent("bonusChestTokenGlobalMP")
		bonusChest = true

		local spawn = Entity.Get(spawnPoint06FxId)
		local coords = spawn:GetCoords()
		
		local fx = Entity.Create("records/fx/ambient/fx_eldritchrift_medium01.dbr")

		if (fx != nil) then
			fx:NetworkEnable()
			fx:SetCoords(coords)
		end
	
	end
	
end

-- Increment the Bonus Timer when a Hero, Boss or Nemesis is killed
function gd.survival.rewards.heroKilled()
	
	if Server then
		Game.SurvivalTimerAdd(4000)
		SurvivalEvent_HeroKill()
	
	end

end

function gd.survival.rewards.bossKilled()
	
	if Server then
		Game.SurvivalTimerAdd(8000)
		SurvivalEvent_BossKill()
	
	end

end

function gd.survival.rewards.nemesisKilled()
	
	if Server then
		Game.SurvivalTimerAdd(12000)
		SurvivalEvent_NemesisKill()
	
	end

end


-- Reset Server Variables and destroy chests
function gd.survival.rewards.resetLootVariables()
	
	if Server then
		rewardUpgraded = false
		bonusChest = false
	
	end

end

function gd.survival.rewards.resetVariablesGlobalMP()

	checkpoint50Used = false
	checkpoint100Used = false

end

function gd.survival.rewards.resetVariables()
	
	if Server then
		rewardDispensed = false
		checkpoint50Used = false
		checkpoint100Used = false
		
		LuaGlobalEvent("resetRewardVariablesGlobalMP")
		
		local totalChests = table.getn(rewardChestIds) + 2
		
		for id = 1, totalChests do
			if rewardChestEntities[id] != nil then
				rewardChestEntities[id]:Destroy()
				rewardChestEntities[id] = nil
			
			end
		
		end
		
		-- Close gate
		local door = Door.Get(rewardDoorId)
	
		if door != nil then
			door:Close()
		end
	
	end

end

-- Starter Potion Chest
function gd.survival.rewards.starterChestFound()

	GiveTokenToLocalPlayer("SURVIVALMODE_STARTERCHEST")
	
end

function gd.survival.rewards.starterChestOnAddToWorld(objectId)
	
	if Server then	
		local chestEntity = Entity.Get(objectId)
		local player = Game.GetLocalPlayer()
	
		-- Destroy chest if this is the initial load and the player has the open token from a previous session
		if (player != nil) && (chestEntity:IsReloaded() == false) && (player:AnyoneHasToken("SURVIVALMODE_STARTERCHEST") || player:GetLevel() > 2) then
			chestEntity:Destroy()
		end
	
	end
	
end


function gd.survival.rewards.checkpoint50UsedGlobalMP()

	checkpoint50Used = true
	
end

function gd.survival.rewards.checkpoint50Used()

	if Server then
		checkpoint50Used = true
		LuaGlobalEvent("checkPoint50UsedGlobalMP")
	
	end
	
end

function gd.survival.rewards.checkpoint100UsedGlobalMP()

	checkpoint100Used = true
	
end

function gd.survival.rewards.checkpoint100Used()

	if Server then
		checkpoint100Used = true
		LuaGlobalEvent("checkPoint100UsedGlobalMP")
	
	end
	
end

function gd.survival.rewards.restartUsedGlobalMP()

	restartUsed = true

end

function gd.survival.rewards.restartUsed()

	if Server then
		restartUsed = true
		LuaGlobalEvent("restartUsedGlobalMP")
	
	end
	
end

function gd.survival.rewards.resetRestartVariableGlobalMP()

	restartUsed = false
	
end

function gd.survival.rewards.resetRestartVariable()

	if Server then
		restartUsed = false
		restartWaveNumber = 0
		LuaGlobalEvent("resetRestartVariableGlobalMP")
	
	end
	
end

function gd.survival.rewards.RestartTest(waveNumber)

	if Server then
		restartWaveNumber = waveNumber
	
	end
		
end

