local Mod = RegisterMod("Instant Restart", 1)

local function inputAction(_,_,_, buttonAction)
    if  Input.IsActionTriggered(ButtonAction.RESTART, 0)
    and buttonAction == ButtonAction.RESTART
    and not Game():IsPaused() and Game():GetLevel():GetStage() == LevelStage.BASEMENT_1
    and not Game():GetLevel():IsAscent() then
        
        Isaac.DebugString("----- instant-restart - Restart -----  ")
        Isaac.ExecuteCommand("restart")

        if Epiphany then
            Epiphany.runRestartedWithR = true
        end

        return false

    end
end
Mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, inputAction, InputHook.IS_ACTION_PRESSED)