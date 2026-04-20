import { ifDevice, map, rule, withCondition } from "karabiner.ts";

// AJAZZ
export const isPurpleKeyboard = () =>
  ifDevice({ vendor_id: 6700, product_id: 39689 });
// SEMITEK
export const isDangoKeyboard = () =>
  ifDevice({ vendor_id: 7847, product_id: 2311 });

export const isExternalKeyboard = () => {
  return [isPurpleKeyboard(), isDangoKeyboard()];
};

const escapeToGrave = map("escape", "optionalAny")
  // "optionalAny" is needed to make this key work as tilde when pressed with modifiers.
  .to("grave_accent_and_tilde")
  .description("Escape to Grave Accent/Tilde");

export function thePurpleKeyboard() {
  return rule("Device Specific Rule for The Purple Keyboard").manipulators([
    withCondition(isPurpleKeyboard())([
      escapeToGrave,

      map("application").to("right_option"),
      map("left_control").to("fn"),
      map("right_control").to("right_option"),
      map("right_option").to("right_command"),
    ]),
  ]);
}

export function dangoKeyboard() {
  return rule("Device Specific Rule for Dango Keyboard") // 2 rules
    .manipulators([
      withCondition(isDangoKeyboard())([
        // "optionalAny" is needed to make this key work as tilde when pressed with modifiers.
        escapeToGrave,

        // map("left_option", "optionalAny").to("left_command"),
        map("left_command").to("left_option"),
        map("left_control").to("fn"),

        // map("right_option").to("right_command"),
        map("application").to("right_option"),
      ]),
    ]);
}
