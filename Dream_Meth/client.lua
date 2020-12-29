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

Citizen.CreateThread(function()
    BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()

    BikerMethLab.Style.Set(BikerMethLab.Style.upgrade, false)
    BikerMethLab.Security.Set(BikerMethLab.Security.upgrade, false)

    RefreshInterior(BikerMethLab.interiorId)
end)

function fadeScreen()
    DoScreenFadeIn(100)
    DoScreenFadeOut(100)
end

Citizen.CreateThread(function()
    local ply = GetPlayerPed(-1)
    local plyloc = GetEntityCoords(ply)
    local textloc1 = vector3(1930.0, 4635.0, 40.5)
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), textloc1) < 7.5 then
            Draw3DText(textloc1.x, textloc1.y, textloc1.z, "[E] - Buy Meth", 0.4)
            if IsControlJustReleased(0, 38) and Vdist2(GetEntityCoords(PlayerPedId()), textloc1) < 5  then
                print("works")
            end
        end
    end
end)

--Entering the interior
Citizen.CreateThread(function()
    local ply = GetPlayerPed(-1)
    local plyloc = GetEntityCoords(ply)
    local textloc2 = vector3(2924.13, 4486.4, 48.0)
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), textloc2) < 5 then
            Draw3DText(textloc2.x, textloc2.y, textloc2.z, "[E] - Enter", 0.4)
            if IsControlJustReleased(0, 38) and Vdist2(GetEntityCoords(PlayerPedId()), textloc2) < 5  then
                SetEntityCoords_2(ply, 996.83, -3200.68, -36.39, false, false, false, false)
                Citizen.Wait(5)
            end
        end
    end
end)

--Exiting the interior
Citizen.CreateThread(function()
    local ply = GetPlayerPed(-1)
    local plyloc = GetEntityCoords(ply)
    local textloc3 = vector3(996.83, -3200.68, -36.39)
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), textloc3) < 5 then
            Draw3DText(textloc3.x, textloc3.y, textloc3.z, "[E] - Exit", 0.4)
            if IsControlJustReleased(0, 38) and Vdist2(GetEntityCoords(PlayerPedId()), textloc3) < 5  then
                SetEntityCoords_2(ply, 2923.85, 4487.44, 48.06, false, false, false, false)
                Citizen.Wait(5)
            end
        end
    end
end)

--2924.13, 4486.4, 48.0

--When teleporting somewhere you cannot teleport anywhere else without having to restart the resource