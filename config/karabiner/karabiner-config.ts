import { type ModificationParameters, writeToProfile } from "karabiner.ts";

import { allRules } from "./libs/rules";
import { parseProfileArgs } from "./libs/utils";

function main() {
  const profile = parseProfileArgs("karabiner-ts");

  const parameters: ModificationParameters = {
    "basic.to_if_alone_timeout_milliseconds": 1000,
    "basic.to_if_held_down_threshold_milliseconds": 500,
    "basic.to_delayed_action_delay_milliseconds": 500,
    "basic.simultaneous_threshold_milliseconds": 50,
    "double_tap.delay_milliseconds": 150,
  };

  writeToProfile(profile, allRules, parameters);
}

main();
