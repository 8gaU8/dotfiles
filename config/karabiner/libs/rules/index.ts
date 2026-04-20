import { launchApp } from "./appLauncher";
import { magicArrows, viArrowsWithFn } from "./arrows";
import { capsLockToControl } from "./capsLocks";
import { emojiLayer } from "./emoji";
import { dangoKeyboard, thePurpleKeyboard } from "./externalKeyboards";
import { nbToFn } from "./functions";
import { commandAsIMESwitch } from "./IME";

export {
  capsLockToControl,
  commandAsIMESwitch,
  dangoKeyboard,
  emojiLayer,
  launchApp,
  magicArrows,
  nbToFn,
  thePurpleKeyboard,
  viArrowsWithFn,
};

export const allRules = [
  // device specific rules
  thePurpleKeyboard(),
  dangoKeyboard(),

  // general rules
  capsLockToControl(),
  commandAsIMESwitch(),
  nbToFn(),

  // utility
  emojiLayer(),
  viArrowsWithFn(),
  magicArrows(),

  // OS utility
  launchApp(),
];
