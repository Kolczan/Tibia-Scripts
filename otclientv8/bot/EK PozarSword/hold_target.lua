local oldTarget
macro(200, "hold target",  function()
    if g_game.isAttacking() then
        oldTarget = g_game.getAttackingCreature()
    end
    if (oldTarget and not g_game.isAttacking() and getDistanceBetween(pos(), oldTarget:getPosition()) <= 8) then
        g_game.attack(oldTarget)
    end
end)