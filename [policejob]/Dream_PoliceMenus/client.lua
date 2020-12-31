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

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent('drp_policemenus:noRoom')

AddEventHandler('drp_policemenus:noRoom', function()
    notify("Not inventory space!")
end)
_menuPool = NativeUI.CreatePool()
bcsoarmoryMenu = NativeUI.CreateMenu("Armory", "~b~Blaine County Sheriff's Office")
_menuPool:Add(bcsoarmoryMenu)
sasparmoryMenu = NativeUI.CreateMenu("Armory", "~b~San Andreas State Police")
_menuPool:Add(sasparmoryMenu)
bcsogarageMenu = NativeUI.CreateMenu("Garage", "~b~Blaine County Sheriff's Office")
_menuPool:Add(bcsogarageMenu)
saspgarageMenu = NativeUI.CreateMenu("Garage", "~b~San Andreas State Police")
_menuPool:Add(saspgarageMenu)

function armoryItems(menu)
    local taser = NativeUI.CreateItem("Taser", "Equip taser?")
    local nightstick = NativeUI.CreateItem("Nightstick", "Equip nightstick?")
    local flashlight = NativeUI.CreateItem("Flashlight", "Equip flashlight?")
    local pistol = NativeUI.CreateItem("Pistol", "Equip pistol?")
    local combatpistol = NativeUI.CreateItem("Combat Pistol", "Equip combat pistol?")
    local mk2pistol = NativeUI.CreateItem("MK2 Pistol", "Equip MK2 pistol?")
    local ar = NativeUI.CreateItem("Carbine Rifle", "Equip carbine rifle?")
    local smg = NativeUI.CreateItem("SMG", "Equip SMG?")
    local shotgun = NativeUI.CreateItem("Shotgun", "Equip shotgun?")
    local sniper = NativeUI.CreateItem("Sniper Rifle", "Equip sniper rifle?")
    menu:AddItem(taser)
    menu:AddItem(nightstick)
    menu:AddItem(flashlight)
    menu:AddItem(pistol)
    menu:AddItem(combatpistol)
    menu:AddItem(mk2pistol)
    menu:AddItem(ar)
    menu:AddItem(smg)
    menu:AddItem(shotgun)
    menu:AddItem(sniper)
    menu.OnItemSelect = function(sender, item, index)
        if item == taser then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_STUNGUN", 1)
        elseif item == nightstick then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_NIGHTSTICK", 1)
        elseif item == flashlight then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_FLASHLIGHT", 1)
        elseif item == pistol then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_PISTOL", 200)
        elseif item == combatpistol then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_COMBATPISTOL", 200)
        elseif item == mk2pistol then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_PISTOL_MK2", 200)
        elseif item == ar then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_CARBINERIFLE_MK2", 250)
        elseif item == smg then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_SMG_MK2", 250)
        elseif item == shotgun then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_PUMPSHOTGUN_MK2", 100)
        elseif item == sniper then
            TriggerServerEvent("drp_policemenus:selectItem", "WEAPON_SNIPERRIFLE", 50)
        end
    end
end

function spawnVehicle(vehicle) --with player in it
    local ped = GetPlayerPed(-1)
    local model = GetHashKey(vehicle)
    RequestModel(model)

    while not HasModelLoaded(model) do
	    Citizen.Wait(0)
    end
		
    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 5.0, 0)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.h, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(model)
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
end

function vehicleItems
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    coords = coords + 
    local cvpi = NativeUI.CreateItem("CVPI", "Spawn CVPI?")
    local charger = NativeUI.CreateItem("Charger", "Spawn Charger?")
    local tau = NativeUI.CreateItem("Taurus", "Spawn Taurus?")
    local exp = NativeUI.CreateItem("Explorer", "Spawn Explorer?")
    local tahoe = NativeUI.CreateItem("Tahoe", "Spawn Tahoe?")
    local van = NativeUI.CreateItem("Tahoe", "Spawn SWAT van?")
    menu:AddItem(cvpi)
    menu:AddItem(charger)
    menu:AddItem(tau)
    menu:AddItem(exp)
    menu:AddItem(tahoe)
    menu:AddItem(van)
    menu.OnItemSelect = function(sender, item, index)
        if item == cvpi then
            spawnVehicle(police)
        elseif item == charger then
            spawnVehicle(police2)
        elseif item == tau then
            spawnVehicle(police3)
        elseif item == exp then
            spawnVehicle(fbi)
        elseif item == tahoe then
            spawnVehicle(fbi2)
        elseif item == van then 
            spawnVehicle(riot)
        end
    end
end

armoryItems(bcsoarmoryMenu)
armoryItems(sasparmoryMenu)
vehicleItems(bcsoarmoryMenu)
vehicleItems(sasparmoryMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)