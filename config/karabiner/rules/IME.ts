import { map, type RuleBuilder, rule, withCondition } from "karabiner.ts";
import { isDangoKeyboard, isPurpleKeyboard } from "./externalKeyboards";

export function commandAsIMESwitch(): RuleBuilder {
  return rule("Command → IME switch").manipulators([
    withCondition(
      isPurpleKeyboard().unless(),
      isDangoKeyboard().unless(),
    )([
      map("left_command").to("left_command").toIfAlone("japanese_eisuu"),
      map("right_command").to("right_command").toIfAlone("japanese_kana"),
    ]),

    withCondition(isPurpleKeyboard())([
      // TODO:
    ]),
    withCondition(isDangoKeyboard())([
      // map("left_option", "optionalAny").to("left_command"),
      map("left_option", "optionalAny")
        .to("left_command")
        .toIfAlone("japanese_eisuu"),

      map("right_option", "optionalAny")
        .to("right_command")
        .toIfAlone("japanese_kana"),
    ]),
  ]);
}
