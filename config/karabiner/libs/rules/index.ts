import { launchApp } from "./appLauncher";
import { magicArrows, viArrowsWithFn } from "./arrows";
import { capsLockToControl } from "./capsLock";
import { emojiLayer } from "./emoji";
import { nbToFn } from "./functions";
import { allDeviceRules } from "./keyboardsSpecific";

export {
  capsLockToControl,
  emojiLayer,
  launchApp,
  magicArrows,
  nbToFn,
  viArrowsWithFn,
};

export const allRules = [
  // device specific rules
  ...allDeviceRules,

  // general rules
  capsLockToControl(),
  nbToFn(),

  // utility
  viArrowsWithFn(),
  magicArrows(),

  // OS utility
  launchApp(),
];
