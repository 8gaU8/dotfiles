import { map, type RuleBuilder, rule } from "karabiner.ts";

export function commandAsIMESwitch(): RuleBuilder {
  return rule("Command → IME switch").manipulators([
    map("left_command").to("left_command").toIfAlone("japanese_eisuu"),
    map("right_command").to("right_command").toIfAlone("japanese_kana"),
  ]);
}
