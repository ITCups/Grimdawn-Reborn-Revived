/*
	
	GRIM DAWN SURVIVAL MODE
	
	For more information, visit us at http://www.grimdawn.com
	
*/

gd.survival.defenses = {}

--
-- Controls for the player-made defenses available throughout the arena
-- Once spawned, a defense cannot be replaced and its associated NPC is despawned
--
local defensePointId = {0, 0, 0, 0}
local defensePointNPCEntity = {nil, nil, nil, nil}
local defensePointNPCId = {0, 0, 0, 0}
local defensePointNPCCoords = {nil, nil, nil, nil}

-- 0 = No Spawn, 1 = Defense Banner, 2 = Offense Banner, 3 = Fire Turret, 4 = Ice Turret, 5 = Lightning Turret, 6 = Wall
local defensePointState = {0, 0, 0, 0}
local defensePointUpgradeState = {0, 0, 0, 0}
local defensePointDbrs = {"records/creatures/defenses/banner_defense.dbr", "records/creatures/defenses/banner_offense.dbr", "records/creatures/defenses/turret_fire.dbr", "records/creatures/defenses/turret_ice.dbr", "records/creatures/defenses/turret_lightning.dbr"}
local defensePointDbrsUpgrade01 = {"records/creatures/defenses/banner_defense02.dbr", "records/creatures/defenses/banner_offense02.dbr", "records/creatures/defenses/turret_fire02.dbr", "records/creatures/defenses/turret_ice02.dbr", "records/creatures/defenses/turret_lightning02.dbr"}
local defensePointDbrsUpgrade02 = {"records/creatures/defenses/banner_defense03.dbr", "records/creatures/defenses/banner_offense03.dbr", "records/creatures/defenses/turret_fire03.dbr", "records/creatures/defenses/turret_ice03.dbr", "records/creatures/defenses/turret_lightning03.dbr"}
local defensePointSpawned = {false, false, false, false}
local defensePointEntity = {nil, nil, nil, nil}

-- Defense Point 01 Initialization
function gd.survival.defenses.defensePoint01OnAddToWorld(objectId)

	if Server then
		defensePointId[1] = objectId
		-- Defense Points spawn monster entities, which are permanently saved into the world once spawned
	
	end

end

function gd.survival.defenses.defensePointNPC01OnAddToWorld(objectId)

	if Server then
		local entity = Entity.Get(objectId)
		defensePointNPCCoords[1] = entity:GetCoords()
		
		-- Spawn/respawn the NPC only if the associated Defense Point isn't already spawned
		if entity != nil && defensePointState[1] == 0 && not defensePointSpawned[1] then
			if defensePointUpgradeState[1] == 2 then
				defensePointNPCEntity[1] = Entity.Create ("records/creatures/npcs/npc_defensesite_01c.dbr")
			elseif defensePointUpgradeState[1] == 1 then
				defensePointNPCEntity[1] = Entity.Create ("records/creatures/npcs/npc_defensesite_01b.dbr")
			else
				defensePointNPCEntity[1] = Entity.Create ("records/creatures/npcs/npc_defensesite_01.dbr")
			end
			defensePointNPCEntity[1]:SetCoords(defensePointNPCCoords[1])
			defensePointNPCId[1] = defensePointNPCEntity[1]:GetId()
		
		end
	
	end

end

-- Defense Point 02 Initialization
function gd.survival.defenses.defensePoint02OnAddToWorld(objectId)

	if Server then
		defensePointId[2] = objectId
		-- Defense Points spawn monster entities, which are permanently saved into the world once spawned
	
	end

end

function gd.survival.defenses.defensePointNPC02OnAddToWorld(objectId)

	if Server then
		local entity = Entity.Get(objectId)
		defensePointNPCCoords[2] = entity:GetCoords()
		
		-- Spawn/respawn the NPC only if the associated Defense Point isn't already spawned
		if entity != nil && defensePointState[2] == 0 && not defensePointSpawned[2] then
			if defensePointUpgradeState[2] == 2 then
				defensePointNPCEntity[2] = Entity.Create ("records/creatures/npcs/npc_defensesite_02c.dbr")
			elseif defensePointUpgradeState[2] == 1 then
				defensePointNPCEntity[2] = Entity.Create ("records/creatures/npcs/npc_defensesite_02b.dbr")
			else
				defensePointNPCEntity[2] = Entity.Create ("records/creatures/npcs/npc_defensesite_02.dbr")
			end
			defensePointNPCEntity[2]:SetCoords(defensePointNPCCoords[2])
			defensePointNPCId[2] = defensePointNPCEntity[2]:GetId()
		
		end
	
	end

end

-- Defense Point 03 Initialization
function gd.survival.defenses.defensePoint03OnAddToWorld(objectId)

	if Server then
		defensePointId[3] = objectId
		-- Defense Points spawn monster entities, which are permanently saved into the world once spawned
	
	end

end

function gd.survival.defenses.defensePointNPC03OnAddToWorld(objectId)

	if Server then
		local entity = Entity.Get(objectId)
		defensePointNPCCoords[3] = entity:GetCoords()
		
		-- Spawn/respawn the NPC only if the associated Defense Point isn't already spawned
		if entity != nil && defensePointState[3] == 0 && not defensePointSpawned[3] then
			if defensePointUpgradeState[3] == 2 then
				defensePointNPCEntity[3] = Entity.Create ("records/creatures/npcs/npc_defensesite_03c.dbr")
			elseif defensePointUpgradeState[3] == 1 then
				defensePointNPCEntity[3] = Entity.Create ("records/creatures/npcs/npc_defensesite_03b.dbr")
			else
				defensePointNPCEntity[3] = Entity.Create ("records/creatures/npcs/npc_defensesite_03.dbr")
			end
			defensePointNPCEntity[3]:SetCoords(defensePointNPCCoords[3])
			defensePointNPCId[3] = defensePointNPCEntity[3]:GetId()
		
		end
	
	end

end

-- Defense Point 04 Initialization
function gd.survival.defenses.defensePoint04OnAddToWorld(objectId)

	if Server then
		defensePointId[4] = objectId
		-- Defense Points spawn monster entities, which are permanently saved into the world once spawned
	
	end

end

function gd.survival.defenses.defensePointNPC04OnAddToWorld(objectId)

	if Server then
		local entity = Entity.Get(objectId)
		defensePointNPCCoords[4] = entity:GetCoords()
		
		-- Spawn/respawn the NPC only if the associated Defense Point isn't already spawned
		if entity != nil && defensePointState[4] == 0 && not defensePointSpawned[4] then
			if defensePointUpgradeState[4] == 2 then
				defensePointNPCEntity[4] = Entity.Create ("records/creatures/npcs/npc_defensesite_04c.dbr")
			elseif defensePointUpgradeState[4] == 1 then
				defensePointNPCEntity[4] = Entity.Create ("records/creatures/npcs/npc_defensesite_04b.dbr")
			else
				defensePointNPCEntity[4] = Entity.Create ("records/creatures/npcs/npc_defensesite_04.dbr")
			end
			defensePointNPCEntity[4]:SetCoords(defensePointNPCCoords[4])
			defensePointNPCId[4] = defensePointNPCEntity[4]:GetId()
		
		end
	
	end

end


-- Disable/Enable all Defense Site NPCs
function gd.survival.defenses.enableDefenseSites()

	if Server then
		local defensePoints = table.getn(defensePointNPCId)
		
		for id = 1, defensePoints do
			local NPC = Npc.Get(defensePointNPCId[id])
			
			if NPC != nil then
				NPC:SetAvailableForConversation(true)
			
			end
			
		end
	
	end

end

function gd.survival.defenses.disableDefenseSites()

	if Server then
		local defensePoints = table.getn(defensePointNPCId)
		
		for id = 1, defensePoints do
			local NPC = Npc.Get(defensePointNPCId[id])
			
			if NPC != nil then
				NPC:SetAvailableForConversation(false)
			
			end
			
		end
	
	end

end


-- Spawn defense object at defensePoint #
local function CharacterCreateArgs()

	local averageLevel = Game.GetAveragePlayerLevel()
	local defenseLevel = ((averageLevel+(averageLevel/50))+1)

	return defenseLevel, nil
	
end

function gd.survival.defenses.spawnObject(defensePoint)

	if Server then
		if defensePointState[defensePoint] != 0 && not defensePointSpawned[defensePoint] then
			local entity = Entity.Get(defensePointId[defensePoint])
			
			if entity != nil then
				local coords = entity:GetCoords()
				
				local fx = Entity.Create("records/fx/ui/riftgatedefensebuilt_fxpak.dbr")

				if (fx != nil) then
					fx:NetworkEnable()
					fx:SetCoords(coords)
				end
				
				if defensePointEntity[defensePoint] != nil then
					defensePointEntity[defensePoint]:Destroy()
				end
				
				if defensePointUpgradeState[defensePoint] == 2 then
					defensePointEntity[defensePoint] = Character.Create (defensePointDbrsUpgrade02[defensePointState[defensePoint]], CharacterCreateArgs())
				elseif defensePointUpgradeState[defensePoint] == 1 then
					defensePointEntity[defensePoint] = Character.Create (defensePointDbrsUpgrade01[defensePointState[defensePoint]], CharacterCreateArgs())
				else
					defensePointEntity[defensePoint] = Character.Create (defensePointDbrs[defensePointState[defensePoint]], CharacterCreateArgs())
					LuaGlobalEvent("defenseBuiltToken")
				end
				
				defensePointEntity[defensePoint]:SetCoords(coords)
				
				-- swap or despawn NPC
				local NPCcoords = defensePointNPCEntity[defensePoint]:GetCoords()
				
				defensePointNPCEntity[defensePoint]:Destroy()
				defensePointNPCEntity[defensePoint] = nil
				
				
				if defensePointUpgradeState[defensePoint] == 2 then
					defensePointSpawned[defensePoint] = true
					local NPCfx = Entity.Create("records/fx/ui/riftgatepersonalopen_fxpak.dbr")

					if (NPCfx != nil) then
						NPCfx:NetworkEnable()
						NPCfx:SetCoords(NPCcoords)
					end

				elseif defensePointUpgradeState[defensePoint] == 1 then
					if defensePoint == 1 then
						defensePointNPCEntity[1] = Entity.Create ("records/creatures/npcs/npc_defensesite_01c.dbr")
						
					elseif defensePoint == 2 then
						defensePointNPCEntity[2] = Entity.Create ("records/creatures/npcs/npc_defensesite_02c.dbr")

					elseif defensePoint == 3 then
						defensePointNPCEntity[3] = Entity.Create ("records/creatures/npcs/npc_defensesite_03c.dbr")

					elseif defensePoint == 4 then
						defensePointNPCEntity[4] = Entity.Create ("records/creatures/npcs/npc_defensesite_04c.dbr")

					end
					
					defensePointNPCEntity[defensePoint]:SetCoords(defensePointNPCCoords[defensePoint])
					defensePointNPCId[defensePoint] = defensePointNPCEntity[defensePoint]:GetId()
						
				else
					if defensePoint == 1 then
						defensePointNPCEntity[1] = Entity.Create ("records/creatures/npcs/npc_defensesite_01b.dbr")
						
					elseif defensePoint == 2 then
						defensePointNPCEntity[2] = Entity.Create ("records/creatures/npcs/npc_defensesite_02b.dbr")

					elseif defensePoint == 3 then
						defensePointNPCEntity[3] = Entity.Create ("records/creatures/npcs/npc_defensesite_03b.dbr")

					elseif defensePoint == 4 then
						defensePointNPCEntity[4] = Entity.Create ("records/creatures/npcs/npc_defensesite_04b.dbr")

					end
					
					defensePointNPCEntity[defensePoint]:SetCoords(defensePointNPCCoords[defensePoint])
					defensePointNPCId[defensePoint] = defensePointNPCEntity[defensePoint]:GetId()

				end
			
			end
			
		end

	end
	
end


-- Defense Point 01 Spawn Functions
function gd.survival.defenses.setDefensePoint01_BannerDefense()
	
	if Server then
		defensePointState[1] = 1
		gd.survival.defenses.spawnObject(1)
	end
	
end

function gd.survival.defenses.setDefensePoint01_BannerOffense()
	
	if Server then
		defensePointState[1] = 2
		gd.survival.defenses.spawnObject(1)
	end
	
end

function gd.survival.defenses.setDefensePoint01_TurretFire()
	
	if Server then
		defensePointState[1] = 3
		gd.survival.defenses.spawnObject(1)
	end
	
end

function gd.survival.defenses.setDefensePoint01_TurretIce()
	
	if Server then
		defensePointState[1] = 4
		gd.survival.defenses.spawnObject(1)
	end
	
end

function gd.survival.defenses.setDefensePoint01_TurretLightning()
	
	if Server then
		defensePointState[1] = 5
		gd.survival.defenses.spawnObject(1)
	end
	
end

function gd.survival.defenses.setDefensePoint01_Wall()
	
	if Server then
		defensePointState[1] = 6
		gd.survival.defenses.spawnObject(1)
	end
	
end


-- Defense Point 02 Spawn Functions
function gd.survival.defenses.setDefensePoint02_BannerDefense()
	
	if Server then
		defensePointState[2] = 1
		gd.survival.defenses.spawnObject(2)
	end
	
end

function gd.survival.defenses.setDefensePoint02_BannerOffense()
	
	if Server then
		defensePointState[2] = 2
		gd.survival.defenses.spawnObject(2)
	end
	
end

function gd.survival.defenses.setDefensePoint02_TurretFire()
	
	if Server then
		defensePointState[2] = 3
		gd.survival.defenses.spawnObject(2)
	end
	
end

function gd.survival.defenses.setDefensePoint02_TurretIce()
	
	if Server then
		defensePointState[2] = 4
		gd.survival.defenses.spawnObject(2)
	end
	
end

function gd.survival.defenses.setDefensePoint02_TurretLightning()
	
	if Server then
		defensePointState[2] = 5
		gd.survival.defenses.spawnObject(2)
	end
	
end

function gd.survival.defenses.setDefensePoint02_Wall()
	
	if Server then
		defensePointState[2] = 6
		gd.survival.defenses.spawnObject(2)
	end
	
end


-- Defense Point 03 Spawn Functions
function gd.survival.defenses.setDefensePoint03_BannerDefense()
	
	if Server then
		defensePointState[3] = 1
		gd.survival.defenses.spawnObject(3)
	end
	
end

function gd.survival.defenses.setDefensePoint03_BannerOffense()
	
	if Server then
		defensePointState[3] = 2
		gd.survival.defenses.spawnObject(3)
	end
	
end

function gd.survival.defenses.setDefensePoint03_TurretFire()
	
	if Server then
		defensePointState[3] = 3
		gd.survival.defenses.spawnObject(3)
	end
	
end

function gd.survival.defenses.setDefensePoint03_TurretIce()
	
	if Server then
		defensePointState[3] = 4
		gd.survival.defenses.spawnObject(3)
	end
	
end

function gd.survival.defenses.setDefensePoint03_TurretLightning()
	
	if Server then
		defensePointState[3] = 5
		gd.survival.defenses.spawnObject(3)
	end
	
end

function gd.survival.defenses.setDefensePoint03_Wall()
	
	if Server then
		defensePointState[3] = 6
		gd.survival.defenses.spawnObject(3)
	end
	
end


-- Defense Point 04 Spawn Functions
function gd.survival.defenses.setDefensePoint04_BannerDefense()
	
	if Server then
		defensePointState[4] = 1
		gd.survival.defenses.spawnObject(4)
	end
	
end

function gd.survival.defenses.setDefensePoint04_BannerOffense()
	
	if Server then
		defensePointState[4] = 2
		gd.survival.defenses.spawnObject(4)
	end
	
end

function gd.survival.defenses.setDefensePoint04_TurretFire()
	
	if Server then
		defensePointState[4] = 3
		gd.survival.defenses.spawnObject(4)
	end
	
end

function gd.survival.defenses.setDefensePoint04_TurretIce()
	
	if Server then
		defensePointState[4] = 4
		gd.survival.defenses.spawnObject(4)
	end
	
end

function gd.survival.defenses.setDefensePoint04_TurretLightning()
	
	if Server then
		defensePointState[4] = 5
		gd.survival.defenses.spawnObject(4)
	end
	
end

function gd.survival.defenses.setDefensePoint04_Wall()
	
	if Server then
		defensePointState[4] = 6
		gd.survival.defenses.spawnObject(4)
	end
	
end


-- Upgrade Defense Point
function gd.survival.defenses.upgradeDefensePoint01()
	
	if Server then
		defensePointUpgradeState[1] = defensePointUpgradeState[1] + 1
		gd.survival.defenses.spawnObject(1)
	end
	
end

function gd.survival.defenses.upgradeDefensePoint02()
	
	if Server then
		defensePointUpgradeState[2] = defensePointUpgradeState[2] + 1
		gd.survival.defenses.spawnObject(2)
	end
	
end

function gd.survival.defenses.upgradeDefensePoint03()
	
	if Server then
		defensePointUpgradeState[3] = defensePointUpgradeState[3] + 1
		gd.survival.defenses.spawnObject(3)
	end
	
end

function gd.survival.defenses.upgradeDefensePoint04()
	
	if Server then
		defensePointUpgradeState[4] = defensePointUpgradeState[4] + 1
		gd.survival.defenses.spawnObject(4)
	end
	
end


-- Reset Server Variables, despawn defenses and defense NPCs, spawn new defense NPCs
function gd.survival.defenses.resetVariables()
	
	if Server then
		
		local defensePoints = table.getn(defensePointNPCId)
		
		for id = 1, defensePoints do
			if defensePointNPCEntity[id] != nil then
				defensePointNPCEntity[id]:Destroy()
			end
			
			defensePointState[id] = 0
			defensePointSpawned[id] = false
			defensePointUpgradeState[id] = 0
			
			if defensePointEntity[id] != nil then
				defensePointEntity[id]:Destroy()
				defensePointEntity[id] = nil
			end
		
		end

		defensePointNPCEntity[1] = Entity.Create ("records/creatures/npcs/npc_defensesite_01.dbr")
		defensePointNPCEntity[1]:SetCoords(defensePointNPCCoords[1])
		defensePointNPCId[1] = defensePointNPCEntity[1]:GetId()

		defensePointNPCEntity[2] = Entity.Create ("records/creatures/npcs/npc_defensesite_02.dbr")
		defensePointNPCEntity[2]:SetCoords(defensePointNPCCoords[2])
		defensePointNPCId[2] = defensePointNPCEntity[2]:GetId()

		defensePointNPCEntity[3] = Entity.Create ("records/creatures/npcs/npc_defensesite_03.dbr")
		defensePointNPCEntity[3]:SetCoords(defensePointNPCCoords[3])
		defensePointNPCId[3] = defensePointNPCEntity[3]:GetId()

		defensePointNPCEntity[4] = Entity.Create ("records/creatures/npcs/npc_defensesite_04.dbr")
		defensePointNPCEntity[4]:SetCoords(defensePointNPCCoords[4])
		defensePointNPCId[4] = defensePointNPCEntity[4]:GetId()
		
	end

end

