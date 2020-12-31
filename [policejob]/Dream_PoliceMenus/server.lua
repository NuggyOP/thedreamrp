ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('drp_policemenus:selectItem')

AddEventHandler('drp_policemenus:selectItem', function(weapon, ammo)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addWeapon(weapon, ammo)
end)