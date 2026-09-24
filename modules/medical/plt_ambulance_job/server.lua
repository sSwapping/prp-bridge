local medical = {}

---@param src number | string
---@param amount number
function medical.healPlayer(src, amount)
    local target = tonumber(src)
    if not target then return end

    exports['plt_ambulance_job']:RevivePlayer(target)
end

return medical
