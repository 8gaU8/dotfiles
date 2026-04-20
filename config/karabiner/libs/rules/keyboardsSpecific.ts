import {
  type BasicManipulatorBuilder,
  type ConditionBuilder,
  ifDevice,
  map,
  rule,
  withCondition,
} from "karabiner.ts";

// AJAZZ
function isPurpleKeyboard(): ConditionBuilder {
  return ifDevice({ vendor_id: 6700, product_id: 39689 });
}
// SEMITEK
function isDangoKeyboard(): ConditionBuilder {
  return ifDevice({ vendor_id: 7847, product_id: 2311 });
}

function isInternalKeyboard(): ConditionBuilder {
  return ifDevice({ is_built_in_keyboard: true });
}

export function withPurpleKeyboard(manipulators: BasicManipulatorBuilder[]) {
  return withCondition(isPurpleKeyboard())(manipulators);
}

export function withDangoKeyboard(manipulators: BasicManipulatorBuilder[]) {
  return withCondition(isDangoKeyboard())(manipulators);
}

export function withInternalKeyboard(manipulators: BasicManipulatorBuilder[]) {
  return withCondition(isInternalKeyboard())(manipulators);
}

const escapeToGrave = map("escape", "optionalAny")
  // "optionalAny" is needed to make this key work as tilde when pressed with modifiers.
  .to("grave_accent_and_tilde")
  .description("Escape to Grave Accent/Tilde");

export function internalKeyboardRule() {
  return rule("Device Specific Rule for Internal Keyboard").manipulators([
    withInternalKeyboard([
      map("left_command")
        .to("left_command")
        .toIfAlone("japanese_eisuu")
        .description("Left Command to EISUU when pressed alone"),
      map("right_command")
        .to("right_command")
        .toIfAlone("japanese_kana")
        .description("Right Command to KANA when pressed alone"),
    ]),
  ]);
}

export function thePurpleKeyboard() {
  return rule("Device Specific Rule for The Purple Keyboard").manipulators([
    withCondition(isPurpleKeyboard())([
      escapeToGrave,

      map("application", "optionalAny").to("right_option"),
      map("left_control").to("fn"),
      map("right_control").to("right_option"),
      map("right_option").to("right_command"),

      // IME
      map("left_command").to("left_command").toIfAlone("japanese_eisuu"),
      map("right_option", "optionalAny")
        .to("right_command")
        .toIfAlone("japanese_kana"),
    ]),
  ]);
}

export function dangoKeyboard() {
  return rule("Device Specific Rule for Dango Keyboard") // 2 rules
    .manipulators([
      withCondition(isDangoKeyboard())([
        escapeToGrave,

        map("left_command").to("left_option"),
        map("left_control").to("fn"),

        map("application", "optionalAny").to("right_option"),

        // IME
        map("left_option").to("left_command").toIfAlone("japanese_eisuu"),
        map("right_option").to("right_command").toIfAlone("japanese_kana"),
      ]),
    ]);
}

export const allDeviceRules = [
  internalKeyboardRule(),
  thePurpleKeyboard(),
  dangoKeyboard(),
];
