import { ifDevice, map, rule, withCondition } from "karabiner.ts";

export function thePurpleKeyboard() {
  return rule("Device Specific Rule") // 2 rules
    .manipulators([
      withCondition(ifDevice({ vendor_id: 6700, product_id: 39689 }))([
        // "optionalAny" is needed to make this key work as tilde when pressed with modifiers.
        map("escape", "optionalAny")
          .to("grave_accent_and_tilde")
          .description("Escape to Grave Accent/Tilde"),
        map("application").to("right_option"),
        map("left_control").to("fn"),
        map("right_control").to("right_option"),
        map("right_option").to("right_command"),
      ]),
    ]);
}
