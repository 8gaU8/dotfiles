import {
  type BasicManipulatorBuilder,
  type DeviceIdentifier,
  type FromKeyParam,
  ifDevice,
  map,
  rule,
  withCondition,
} from "karabiner.ts";

// AJAZZ
const PURPLE_KEYBOARD_DEVICE = { vendor_id: 6700, product_id: 39689 };
// SEMITEK
const DANGO_KEYBOARD_DEVICE = { vendor_id: 7847, product_id: 2311 };
// MacBook Pro
const INTERNAL_KEYBOARD_DEVICE = { is_built_in_keyboard: true };

const withKeyboard = (
  keyboardSpec: DeviceIdentifier,
  manipulators: BasicManipulatorBuilder[],
) => {
  return withCondition(ifDevice(keyboardSpec))(manipulators);
};

const escapeToGrave = map("escape", "optionalAny")
  // "optionalAny" is needed to make this key work as tilde when pressed with modifiers.
  .to("grave_accent_and_tilde")
  .description("Escape to Grave Accent/Tilde");

/**
 *
 * @param leftMod - The left modifier key to be mapped to Command and IME(EISUU) keys.
 * @param rightMod - The right modifier key to be mapped to Command and IME(KANA) keys.
 * @returns A list of manipulators
 * @example `modToCmdIMC("left_command", "right_command")` will map left_command to left_command and EISUU when pressed alone, and right_command to right_command and KANA when pressed alone.
 * @example `modToCmdIMC("left_option", "right_option")` will map left_option to left_command and EISUU when pressed alone, and right_option to right_command and KANA when pressed alone.
 */
const modToCmdIMC = (leftMod: FromKeyParam, rightMod: FromKeyParam) => {
  return [
    map(leftMod, "optionalAny")
      .to("left_command")
      .toIfAlone("japanese_eisuu")
      .description("Left Command to EISUU when pressed alone"),
    map(rightMod, "optionalAny")
      .to("right_command")
      .toIfAlone("japanese_kana")
      .description("Right Command to KANA when pressed alone"),
  ];
};

const internalKeyboardRule = () => {
  return rule("Device Specific Rule for Internal Keyboard").manipulators([
    withKeyboard(
      INTERNAL_KEYBOARD_DEVICE,
      modToCmdIMC("left_command", "right_command"),
    ),
  ]);
};

const thePurpleKeyboard = () => {
  return rule("Device Specific Rule for The Purple Keyboard").manipulators([
    withKeyboard(PURPLE_KEYBOARD_DEVICE, [
      escapeToGrave,

      // IME
      ...modToCmdIMC("left_option", "right_option"),

      map("left_control", "optionalAny").to("fn"),
      map("left_command", "optionalAny").to("left_option"),
      map("right_control", "optionalAny").to("right_option"),
    ]),
  ]);
};

const dangoKeyboard = () => {
  return rule("Device Specific Rule for Dango Keyboard") // 2 rules
    .manipulators([
      withKeyboard(DANGO_KEYBOARD_DEVICE, [
        escapeToGrave,

        map("left_command", "optionalAny").to("left_option"),
        map("left_control").to("fn"),

        map("application", "optionalAny").to("right_option"),

        // IME
        ...modToCmdIMC("left_option", "right_option"),
      ]),
    ]);
};

export const allDeviceRules = [
  internalKeyboardRule(),
  thePurpleKeyboard(),
  dangoKeyboard(),
];
