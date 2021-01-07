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

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 500, false, false)
end

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
            giveWeapon("WEAPON_STUNGUN")
        elseif item == nightstick then
            giveWeapon("WEAPON_NIGHTSTICK")
        elseif item == flashlight then
            giveWeapon("WEAPON_FLASHLIGHT")
        elseif item == pistol then
            giveWeapon("WEAPON_PISTOL")
        elseif item == combatpistol then
            giveWeapon("WEAPON_COMBATPISTOL")
        elseif item == mk2pistol then
            giveWeapon("WEAPON_PISTOL_MK2")
        elseif item == ar then
            giveWeapon("WEAPON_CARBINERIFLE_MK2")
        elseif item == smg then
            giveWeapon("WEAPON_CARBINERIFLE_MK2")
        elseif item == shotgun then
            giveWeapon("WEAPON_PUMPSHOTGUN_MK2")
        elseif item == sniper then
            giveWeapon("WEAPON_SNIPERRIFLE")
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

function vehicleItems(menu)
    local cvpi = NativeUI.CreateItem("CVPI", "Spawn CVPI?")
    local taurus = NativeUI.CreateItem("Taurus", "Spawn Taurus?")
    local charger = NativeUI.CreateItem("Charger", "Spawn Charger?")
    menu:AddItem(cvpi)
    menu:AddItem(taurus)
    menu:AddItem(charger)
    menu.OnItemSelect = function(sender, item, index)
        if item == cvpi then
            spawnVehicle(police)
        elseif item == taurus then
            spawnVehicle(police2)
        elseif item == charger then
            spawnVehicle(police3)
        end
    end
end

function mainItems(menu)
    local lockerRoom =  _menuPool:AddSubMenu(menu, "Clothing")
    local testItem = NativeUI.CreateItem("Test Item", "Does this work or nah?")
    local onDuty = NativeUI.CreateItem("Clock on duty", "Are you sure you want to clock on?")
    local offDuty = NativeUI.CreateItem("Clock off duty", "Are you sure you want to clock off?")
    submenu:AddItem(testItem)
    menu:AddItem(onDuty)
    menu:AddItem(offDuty)
    testItem.Activated = function(sender, item, index)
        print('works')
    end
    menu.OnItemSelect = function(sender, item, index)
        if item == onDuty then
            --Need to create a check to see if the player is registered for police in the database
        end
    end
end

armoryItems(bcsoarmoryMenu)
armoryItems(sasparmoryMenu)
vehicleItems(bcsogarageMenu)
vehicleItems(saspgarageMenu)
_menuPool:RefreshIndex()

--Menu locations

local prisonARM = vector3(1847, 2599, 45)
local mrpdARM = vector3(0, 0, 0) --put ACTUAL mrpd coords

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        local ply = PlayerPedId()
        local coords = GetEntityCoords(ply)
        local player = PlayerId()
        if #(prisonARM - coords) < 15 then
            Draw3DText(prisonARM.x, prisonARM.y, prisonARM.z, "[E] - Armory", 0.4)
            if #(prisonARM - coords) < 7 and IsControlJustReleased(0, 38) then
                if PlayerData.job == 'sasp' then
                    sasparmoryMenu:Visible(not sasparmoryMenu:Visible())
                elseif PlayerData.job == 'bcso' then
                    bcsoarmoryMenu:Visible(not bcsoarmoryMenu:Visible())
                else
                    notify('Not on duty!')
                end
            end
        end

        if #(mrpdARM - coords) < 5 then
            Draw3DText(mrpdARM.x, mrpdARM.y, mrpdARM.z, "[E] - Armory", 0.4)
            if IsControlJustReleased(0, 38) then
                if PlayerData.job == 'sasp' then
                    sasparmoryMenu:Visible(not sasparmoryMenu:Visible())
                elseif PlayerData.job == 'bcso' then
                    bcsoarmoryMenu:Visible(not bcsoarmoryMenu:Visible())
                else
                    notify('Not on duty!')
                end
            end
        end
    end
end)