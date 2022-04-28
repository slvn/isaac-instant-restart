
local stage_flag
local visit_depths2

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

    if ((Input.IsActionTriggered(ButtonAction.ACTION_RESTART, 0) and (buttonAction == ButtonAction.ACTION_RESTART)) and (not Game():IsPaused())) and (Game():GetLevel():GetStage() == LevelStage.STAGE1_1) and (stage_flag == nil) then
        Isaac.DebugString("----- instant-restart - Restart -----  ")
        Isaac.ExecuteCommand("restart")
        return false
    end
    return nil
end

function Update()
	--reset to be on the safe side, because 0 seconds timer = reset/new run
	local timecounter = Game().TimeCounter
	if timecounter < 1 then
		visit_depths2 = nil;
		stage_flag = nil;
		debugText = "reset"
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Update)

function checkStage()
		if ((Game():GetLevel():GetStage() ~= LevelStage.STAGE1_1) and (stage_flag == nil)) then
			-- leave basement
			stage_flag = true;
		end
		if (Game():GetLevel():GetStage() == LevelStage.STAGE3_2) then
			-- player visited depth2
			visit_depths2 = true;
		elseif (Game():GetLevel():GetStage() == LevelStage.STAGE1_1) then
			if (visit_depths2 ~= nil) then
				-- check the time since the conditions before also occur with reset
				local timecounter2 = Game().TimeCounter
				-- if timer is 0 we are truly in basement
				if timecounter2 < 1 then
					visit_depths2 = nil;
					stage_flag = nil;
				-- otherwise in ascent basement
				else
					-- ascent basement
					stage_flag = true;
				end
			else
				-- normal basement (this one is important, otherwise instant reset wouldn't work if player visited another stage and reseted there)
				stage_flag = nil;
				visit_depths2 = nil;
			end
		end
end

mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, inputAction, InputHook.IS_ACTION_PRESSED)
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, checkStage)

Isaac.DebugString("instant-restart initialized.")
end
}
return require("main")
