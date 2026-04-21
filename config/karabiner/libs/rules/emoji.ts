import { layer, toPaste } from "karabiner.ts";

export function emojiLayer() {
  return layer("z", "emoji").manipulators({
    h: toPaste("💚"),
    j: toPaste("😂"), // joy
  });
}
