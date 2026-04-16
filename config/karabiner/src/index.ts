import { ModificationParameters, writeToProfile } from "karabiner.ts";

import { launchApp } from "./rules/appLauncher";
import { viArrowsWithFn } from "./rules/arrows";
import capsLockToControl from "./rules/capsLocks";
import { emojilayer } from "./rules/emoji";
import { gamingKeyboard } from "./rules/externalKeyboards";
import { nbToFn } from "./rules/functions";
import { commandAsIMESwitch } from "./rules/IME";

function main() {
  // const profile = "--dry-run";
  const profile = "karabiner-ts";
  const rules = [
    capsLockToControl(),
    commandAsIMESwitch(),
    nbToFn(),
    launchApp(),
    emojilayer(),
    viArrowsWithFn(),
    gamingKeyboard(),
  ];
  const parameters: ModificationParameters = {
    "basic.to_if_alone_timeout_milliseconds": 1000,
    "basic.to_if_held_down_threshold_milliseconds": 500,
    "basic.to_delayed_action_delay_milliseconds": 500,
    "basic.simultaneous_threshold_milliseconds": 50,
    "double_tap.delay_milliseconds": 150,
  };

  writeToProfile(profile, rules, parameters);
}

main();
