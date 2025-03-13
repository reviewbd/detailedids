local displayInfo = false
local playerId, playerName, rpFirstName, rpLastName = nil, nil, nil, nil

-- Demande les infos au serveur
RegisterCommand("id", function()
    TriggerServerEvent("requestPlayerInfo")
end, false)

-- Reçoit les infos et les affiche au-dessus du joueur
RegisterNetEvent("displayPlayerInfo")
AddEventHandler("displayPlayerInfo", function(id, fivemName, firstName, lastName)
    playerId, playerName, rpFirstName, rpLastName = id, fivemName, firstName, lastName
    displayInfo = not displayInfo
end)

-- Affichage 3D du texte
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if displayInfo and playerId then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.2, 
                ("🆔 %s | %s\n🎭 %s %s"):format(playerId, playerName, rpFirstName, rpLastName))
        end
    end
end)

-- Fonction pour afficher du texte 3D
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
