ESX = nil

local robbedRecently = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function robLocal(targetPed)
    robbedRecently = true
    
    Citizen.CreateThread(function()
        local dict = 'random@mugging3'
        RequestAnimDict(dict) do 
            Citizen.Wait(10)
        end

        TaskStandStill(targetPed, 12 * 1000)
        FreezeEntityPosition(targetPed, true)
        TaskPlayAnim(targetPed, dict, 'handsup_standing_base', 8.0, -8, 0.01, 8, 0, 0, 0 ,0)

        exports['progressBars']:startUI(12000, "Robbing")
        Citizen.Wait(12 * 1000)
        ClearPedTasks(targetPed)

        ESX.TriggerServerCallback('Dream_RobPed:giveMoney', function(amount)
            FreezeEntityPosition(targetPed, false)
            notify('Robbery ~g~complete')
        end)

        Citizen.Wait(300 * 1000)
        robbedRecently = false
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)

        if IsControlJustPressed(0, 38) then
            local target, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))

            if target then
                local ped = GetPlayerPed(-1)
                local playerCoords = GetEntityCoords(ped, true)
                local targetCoords = GetEntityCoords(targetPed, true)

                if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
                    if robbedRecently then
                        notify('Target was robbed too recently!')
                    elseif IsPedDeadOrDying(targetPed, true) then
                        notify('Target is dead!')
                    elseif GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, true) > 5 then 
                        notify('Target is too far!')
                    else
                        robLocal(targetPed)
                    end
                end
            end
        end
    end
end)