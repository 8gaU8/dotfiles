import { layer, toApp, toPaste } from "karabiner.ts";

export function emojilayer() {
  return layer("z", "emoji").manipulators({
    h: toApp("💚"),
    j: toPaste("😂"), // joy
  });
}
