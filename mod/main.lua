
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file)
    if ____moduleCache[file] then
        return ____moduleCache[file]
    end
    if ____modules[file] then
        ____moduleCache[file] = ____modules[file]()
        return ____moduleCache[file]
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["main"] = function() --[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
mod = RegisterMod("Instant Restart", 1)
function inputAction(self, _entity, _hook, buttonAction)
    if ((Input.IsActionTriggered(ButtonAction.ACTION_RESTART, 0) and (buttonAction == ButtonAction.ACTION_RESTART)) and (not Game():IsPaused())) and (Game():GetLevel():GetStage() == LevelStage.STAGE1_1) then
        Isaac.DebugString("----- LOL instant-restart - Restart -----  ")
        Isaac.ExecuteCommand("restart")
        return false
    end
    return nil
end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, inputAction, InputHook.IS_ACTION_PRESSED)
Isaac.DebugString("instant-restart initialized.")
end,
}
return require("main")
