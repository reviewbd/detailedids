ESX = exports["es_extended"]:getSharedObject()
MySQL = exports['oxmysql'] -- Utilisation de OXMySQL

RegisterNetEvent("requestPlayerInfo")
AddEventHandler("requestPlayerInfo", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local uuid = xPlayer.get("uuid") -- Vérification correcte

        if uuid and uuid ~= "" then
            MySQL.scalar("SELECT uuid FROM users WHERE uuid = ?", {uuid}, function(dbUuid)
                SendPlayerInfo(_source, xPlayer, dbUuid or "Pas d'UUID")
            end)
        else
            print("[detailedids] Erreur: UUID invalide pour le joueur " .. _source)
            SendPlayerInfo(_source, xPlayer, "Pas d'UUID")
        end
    else
        print("[detailedids] Erreur: Impossible de récupérer xPlayer pour " .. _source)
    end
end)

-- Fonction pour envoyer les infos au client
function SendPlayerInfo(playerId, xPlayer, uuid)
    local playerName = GetPlayerName(playerId) -- Nom FiveM
    local rpFirstName = xPlayer.get("firstName") or "Inconnu"
    local rpLastName = xPlayer.get("lastName") or "Inconnu"
    local job = xPlayer.getJob().label or "Sans emploi" -- Récupère le job

    -- Envoie les infos au client
    TriggerClientEvent("displayPlayerInfo", playerId, {
        id = playerId,
        fivemName = playerName,
        firstName = rpFirstName,
        lastName = rpLastName,
        uuid = uuid,
        job = job
    })
end
