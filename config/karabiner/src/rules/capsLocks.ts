import { type RuleBuilder, rule, map } from "karabiner.ts";

export default function capsLockToControl(): RuleBuilder {
  return rule("Left Control → Control/Escape").manipulators([
    map("caps_lock", "optionalAny")
      .to("left_control", undefined, { lazy: true })
      .toIfAlone("escape")
      .toIfHeldDown("left_control"),
  ]);
}
