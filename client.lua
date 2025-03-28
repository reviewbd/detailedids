local displayInfo = false
local playerInfo = {}

-- Demande les infos au serveur
RegisterCommand("id", function()
    TriggerServerEvent("requestPlayerInfo")
end, false)

-- Reçoit et met à jour les infos en direct
RegisterNetEvent("displayPlayerInfo")
AddEventHandler("displayPlayerInfo", function(info)
    playerInfo = info
    displayInfo = true
end)

-- Mise à jour automatique (si job, nom RP ou UUID change)
RegisterNetEvent("updatePlayerInfo")
AddEventHandler("updatePlayerInfo", function(info)
    playerInfo = info
end)

-- Affichage 3D du texte
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if displayInfo and playerInfo.id then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.2, 
                ("🆔 %s | %s\n🎭 %s %s\n🔑 %s\n💼 %s"):format(
                    playerInfo.id, playerInfo.fivemName, 
                    playerInfo.firstName, playerInfo.lastName, 
                    playerInfo.uuid,
                    playerInfo.job
                )
            )
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
