import process from "node:process";
import { type ModificationParameters, writeToProfile } from "karabiner.ts";
import yargs from "yargs";

import {
  capsLockToControl,
  commandAsIMESwitch,
  emojiLayer,
  launchApp,
  nbToFn,
  thePurpleKeyboard,
  viArrowsWithFn,
} from "./rules";

function parseProfileArgs() {
  let profile = "Default Profile";
  const args = yargs(process.argv.slice(2))
    .option("dryRun", {
      alias: "d",
      type: "boolean",
      description: "Run in dry-run mode without applying changes",
    })
    .option("profile", {
      alias: "p",
      type: "string",
      description: "Specify the profile to modify",
    })
    .parseSync();

  if (args.dryRun) profile = "--dry-run";
  else if (args.profile) profile = args.profile;

  return profile;
}

function main() {
  const profile = parseProfileArgs();

  const rules = [
    capsLockToControl(),
    commandAsIMESwitch(),
    nbToFn(),
    launchApp(),
    emojiLayer(),
    viArrowsWithFn(),
    thePurpleKeyboard(),
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
