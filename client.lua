local markerType = 28 -- Choose the type of marker you want to use
local markerColor = {r = 24, g = 122, b = 233, a = 100} -- Set the color and alpha value of the marker
local fadeOutDuration = 500 -- Duration in milliseconds for the fade out animation

local voiceRange = 0
local fadeOutProgress = 1

function updateFadeOutProgress()
    fadeOutProgress = 0
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local currentAlpha = math.floor(markerColor.a * (1 - fadeOutProgress))

        if currentAlpha > 0 then
            DrawMarker(markerType, coords.x, coords.y, coords.z - 0.5, 0, 0, 0, 0, 0, 0, voiceRange, voiceRange, voiceRange, markerColor.r, markerColor.g, markerColor.b, currentAlpha, false, true, 2, nil, nil, false)
        end

        fadeOutProgress = math.min(fadeOutProgress + (1 / fadeOutDuration * 10), 1)

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(newVoiceRange, index, availableVoiceRanges)
    voiceRange = newVoiceRange
    updateFadeOutProgress()
end)