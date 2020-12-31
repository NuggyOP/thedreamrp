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

local prisonARM = vector3(1847, 2599, 45)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
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
    end
end)