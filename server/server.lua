local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("ES-Diving:server:Reward", function(ped)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local rand = math.random(1, 100)
    local case = math.random(1, 2)
    local item = Config.Items[math.random(1, #Config.Items)]
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    if coords.z > 1.5 then
        DropPlayer(src, "ES-Diving | ANTICHEAT")
        print("ES-DIVING | ANTICHEAT | " .. Player.PlayerData.citizenid .. " | DEPTH GREATER THAN 1.5")
        return
    end

    if rand <= Config.CaseChance then
        if case <= 1 then
            item = "leather_case"
        else
            item = "steel_case"
        end
    end

    Player.Functions.AddItem(item, 1)
    TriggerEvent("ES-Skills:server:IncreaseSkill", math.random(1, 10), "diving", src)
end)

QBCore.Functions.CreateUseableItem('waterproof_metaldetector', function(source, item)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.Functions.GetItemByName(item.name) then return end
	
    TriggerClientEvent("ES-Diving:client:Dive", src)
end)
