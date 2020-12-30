ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()

    BikerMethLab.Style.Set(BikerMethLab.Style.upgrade, false)
    BikerMethLab.Security.Set(BikerMethLab.Security.upgrade, false)

    RefreshInterior(BikerMethLab.interiorId)
end)

function Draw3DText(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    
    DrawText(_x, _y)

    local factor = (string.len(text)) / 700
    DrawRect(_x, _y + 0.0150, 0.06 + factor, 0.03, 41, 11, 41, 100)
end

local textloc2 = vec(2924.13, 4486.4, 48.0)
local textloc3 = vec(996.83, -3200.68, -36.39)
local insideLoc = vec(996.83, -3200.68, -36.39, 271.63)
local outsideLoc = vec(2924.13, 4486.4, 48.0, 36.53)

--Entering the interior
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ply = PlayerPedId()
        local coords = GetEntityCoords(ply)
        local player = PlayerId()
        
        if Vdist2(GetEntityCoords(PlayerPedId(), false), textloc2) < 5 then
            Draw3DText(textloc2.x, textloc2.y, textloc2.z, "[E] - Enter", 0.4)
            if IsControlJustReleased(0, 38) then
                StartPlayerTeleport(player, insideLoc, false, false, false)
            end
        end

        if Vdist2(GetEntityCoords(PlayerPedId(), false), textloc3) < 5 then
            Draw3DText(textloc3.x, textloc3.y, textloc3.z, "[E] - Exit", 0.4)
            if IsControlJustReleased(0, 38) then
                StartPlayerTeleport(player, oustideLoc, false, false, false)
            end
        end
    end
end)

--entering coords 2924.13, 4486.4, 48.0

--exiting coords 996.83, -3200.68, -36.39