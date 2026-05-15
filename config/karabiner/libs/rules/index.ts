import { launchApp } from "./appLauncher";
import { capsLockToControl } from "./capsLock";
import { fnToMediaControl, nbToFn } from "./functions";
import { allDeviceRules } from "./keyboardsSpecific";

export const allRules = [
  // device specific rules
  ...allDeviceRules,

  // general rules
  capsLockToControl(),
  nbToFn(),

  // utility
  // viArrowsWithFn(),
  // magicArrows(),

  // OS utility
  launchApp(),
  fnToMediaControl(),
];
