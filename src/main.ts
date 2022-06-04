import {
  ButtonAction,
  LevelStage,
  ModCallback,
  InputHook
} from "isaac-typescript-definitions";

// Register the mod
const mod = RegisterMod("Instant Restart", 1);

// Define callback functions
function inputAction(
  _entity: Entity | undefined,
  _hook: InputHook,
  buttonAction: ButtonAction,
): number | boolean | void {
  if (
    Input.IsActionTriggered(ButtonAction.RESTART, 0) &&
    buttonAction === ButtonAction.RESTART &&
    !Game().IsPaused() &&
    Game().GetLevel().GetStage() === LevelStage.BASEMENT_1 &&
    !Game().GetLevel().IsAscent()
  ) {
    Isaac.DebugString("----- LOL instant-restart - Restart -----  ");
    Isaac.ExecuteCommand("restart");
    return false;
  }
}

// Register callbacks
mod.AddCallback(
  ModCallback.INPUT_ACTION,
  inputAction,
  InputHook.IS_ACTION_PRESSED,
);
