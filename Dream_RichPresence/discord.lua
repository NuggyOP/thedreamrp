Citizen.CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)
        Citizen.Wait(5*1000)

        SetDiscordAppId(775431017263530015)
        SetRichPresence()

        SetDiscordRichPresenceAsset("dreamrp")
        SetDiscordRichPresenceAssetText("Dream RP")
    end
end)