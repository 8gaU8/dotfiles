import { map, type RuleBuilder, rule } from "karabiner.ts";

export function capsLockToControl(): RuleBuilder {
  const description = "Caps Lock to Left Control when held, Escape when tapped";
  return rule("Left Control → Control/Escape").manipulators([
    map("caps_lock", "optionalAny")
      .to("left_control", {}, { lazy: true })
      .toIfAlone("escape")
      .toIfHeldDown("left_control")
      .description(description),
  ]);
}
