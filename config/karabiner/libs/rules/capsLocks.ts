import { map, type RuleBuilder, rule, ModifierParam } from "karabiner.ts";

export function capsLockToControl(): RuleBuilder {
  const description = "Caps Lock to Left Control when held, Escape when tapped";
  return rule("Left Control → Control/Escape").manipulators([
    map("caps_lock", "optionalAny")
      // ModifierParam should be "undefiend" to preserve the default parameters (just in case)
      .to("left_control", undefined, { lazy: true })
      .toIfAlone("escape")
      .toIfHeldDown("left_control")
      .description(description),
  ]);
}
