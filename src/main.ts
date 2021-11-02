// Register the mod
const mod = RegisterMod("Instant Restart", 1);

// Define callback functions
function inputAction(
  _entity: Entity,
  _hook: any,
  buttonAction: ButtonAction,
): number | boolean | null {
  if (
    Input.IsActionTriggered(ButtonAction.ACTION_RESTART, 0) &&
    buttonAction === ButtonAction.ACTION_RESTART &&
    !Game().IsPaused() &&
    Game().GetLevel().GetStage() === LevelStage.STAGE1_1
  ) {
    Isaac.DebugString("----- LOL instant-restart - Restart -----  ");
    Isaac.ExecuteCommand("restart");
    return false;
  }
  return null;
}

// Register callbacks
mod.AddCallback(
  ModCallbacks.MC_INPUT_ACTION,
  inputAction,
  InputHook.IS_ACTION_PRESSED,
);

// Print an initialization message to the "log.txt" file
Isaac.DebugString("instant-restart initialized.");
