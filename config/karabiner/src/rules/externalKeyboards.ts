import { ifDevice, map, rule, withCondition } from "karabiner.ts";

export function thePurpleKeyboard() {
  return rule("Device Specific Rule") // 2 rules
    .manipulators([
      withCondition(ifDevice({ vendor_id: 6700, product_id: 39689 }))([
        map("application").to("right_option"),
        map("escape").to("grave_accent_and_tilde"),
        map("left_control").to("fn"),
        map("right_control").to("right_option"),
        map("right_option").to("right_command"),
      ]),
    ]);
}
