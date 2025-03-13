ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("requestPlayerInfo")
AddEventHandler("requestPlayerInfo", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local playerId = _source
        local playerName = GetPlayerName(_source) -- Nom FiveM
        local rpFirstName = xPlayer.get("firstName") or "Inconnu"
        local rpLastName = xPlayer.get("lastName") or "Inconnu"

        -- Envoie les infos au client
        TriggerClientEvent("displayPlayerInfo", _source, playerId, playerName, rpFirstName, rpLastName)
    end
end)
