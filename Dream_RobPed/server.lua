ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Dream_RobPed:giveMoney', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = math.random(55, 250)
    xPlayer.addMoney(money)
    callback(money)
end)