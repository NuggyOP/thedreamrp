ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('drp_policejob:drag')
AddEventHandler('drp_policejob:drag', function(target)
	TriggerClientEvent('drp_policejob:drag', target, source) --target is the target of the drag event and source is the id of the cop
end)

RegisterNetEvent('drp_policejob:cuff')
AddEventHandler('drp_policejob:cuff', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'sasp' or xPlayer.job.name == 'bcso' then
        TriggerClientEvent("drp_policejob:cuff", target)
    else
        return
    end
end)