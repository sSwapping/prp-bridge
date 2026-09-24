local medical = {}

---@param serverId number
---@return boolean
function medical.isPlayerDead(serverId)
    if GetResourceState('plt_ambulance_job') ~= 'started' then return false end

    return exports['plt_ambulance_job']:isPlayerDead(serverId) == true
end

---@param value number
function medical.overrideMaxHealth(value)
    -- Integrations with other resources
end

if bridge.name == bridge.currentResource then
    CreateThread(function()
        local cachedDeadState = false

        while true do
            local isDead = medical.isPlayerDead(cache.serverId)

            if cachedDeadState ~= isDead then
                cachedDeadState = isDead

                if isDead then
                    TriggerServerEvent("prp-bridge:server:died")
                    TriggerEvent("prp-bridge:client:died")
                else
                    TriggerServerEvent("prp-bridge:server:revived")
                    TriggerEvent("prp-bridge:client:revived")
                end
            end

            Wait(500)
        end
    end)
end

return medical
