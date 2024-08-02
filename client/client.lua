local QBCore = exports['qb-core']:GetCoreObject()
local lastPos = nil

RegisterNetEvent("ES-Diving:client:Dive", function()
    local ped = PlayerPedId()
    local depth = GetEntityHeightAboveGround(ped)
    local swimming = IsPedSwimmingUnderWater(ped)
    local dist = nil
    local coords = GetEntityCoords(ped)

    if lastPos ~= nil then
        dist = #(lastPos - coords)
    end

    if dist ~= nil then
        if dist < 1.5 then
            QBCore.Functions.Notify("Cant Search The Same Spot", "error")
            return
        end
    end

    if depth > 1.5 then
        QBCore.Functions.Notify("To Far From Seabed", "error")
        return
    end

    if not swimming then
        QBCore.Functions.Notify("You Are Not Swimming", "error")
        return
    end

    FreezeEntityPosition(ped, true)
    lastPos = coords
    QBCore.Functions.Progressbar('dig_dive', 'Detecting...', (Config.DigTime * 1000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
        }, {}, {}, {}, function()
            FreezeEntityPosition(ped, false)
            TriggerServerEvent("ES-Diving:server:Reward")
        end, function()
            FreezeEntityPosition(ped, false)
    end)
end)