ESX              = nil
local PlayerData = {}
local isDead = false

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

--Removes picking up weapon drops
function RemoveWeaponDrops()
    local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH", "PICKUP_WEAPON_RAYCARBINE"}
    for a = 1, #pickupList do
		N_0x616093ec6b139dd9(PlayerId(), GetHashKey(pickupList[a]), false)
    end
end

Citizen.CreateThread(function()     
    RemoveWeaponDrops()
end)

local holstered = true

local weapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_STUNGUN",	
	"WEAPON_NIGHTSTICK",
	"WEAPON_FLASHLIGHT",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_FLARE",
	"WEAPON_SNSPISTOl",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_FLARE",
	"WEAPON_FLARE",
	"WEAPON_FLARE",
	"WEAPON_KNIFE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_MACHINEPISTOL",				
}

--hold holster
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(PlayerPedId(), true) then
            DisableControlAction(0, 20, true) --(z)
            if not IsPauseMenuActive() then
                loadAnimDict( "reaction@intimidation@cop@unarmed" )
                if IsDisabledControlJustReleased( 0, 20 ) then --(z)
                    ClearPedTasks(ped)
                    SetEnableHandcuffs(ped, false)
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                else
                    if IsDisabledControlJustPressed( 0, 20 ) then --(z)
                        SetEnableHandcuffs(ped, true)
                        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)                             
                        TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                    end
                    if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then 
                        DisableActions(ped)
                    end
                end
            end
        end
    end
end)

--Pull out anim
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("move_jump@weapons@pistol")
		loadAnimDict("weapons@pistol@")
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) then
		    if DoesEntityExist(ped) and not IsEntityDead(ped) and GetVehiclePedIsTryingToEnter(ped) == 0 and not IsPedInParachuteFreeFall (ped) then
			    if CheckWeapon(ped) then
				    if holstered then
					    blocked = true
					    TaskPlayAnim(ped, "move_jump@weapons@pistol", "hand_grip", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
					    Citizen.Wait(2500)
					    ClearPedTasks(ped)
					    holstered = false
				    else
					    blocked = false
				    end
			    else
				    if not holstered then
					    TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(1500)
						ClearPedTasks(ped)
						holstered = true
				    end
			    end
		    else
			    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
		    end
		else
			holstered = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if blocked then
				DisableControlAction(1, 25, true )
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				DisableControlAction(1, 23, true)
				DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
				DisablePlayerFiring(ped, true) -- Disable weapon firing
			end
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end