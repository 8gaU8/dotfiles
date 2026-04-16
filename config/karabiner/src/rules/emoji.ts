import { layer, toApp, toPaste } from "karabiner.ts";

export function emojiLayer() {
  return layer("z", "emoji").manipulators({
    h: toApp("💚"),
    j: toPaste("😂"), // joy
  });
}
