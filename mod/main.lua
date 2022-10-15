local Mod = RegisterMod("Instant Restart", 1)

local function inputAction(_,_,_, buttonAction)
    if  Input.IsActionTriggered(ButtonAction.ACTION_RESTART, 0)
    and buttonAction == ButtonAction.ACTION_RESTART
    and not Game():IsPaused()
    and Game():GetLevel():GetStage() == LevelStage.STAGE1_1
    and not Game():GetLevel():IsAscent() then
        
        Isaac.DebugString("----- instant-restart - Restart -----  ")

        if Epiphany then
            Epiphany.runRestartedWithRInstant = true
        end
        
        Isaac.ExecuteCommand("restart")

        return false

    end
end
Mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, inputAction, InputHook.IS_ACTION_PRESSED)
