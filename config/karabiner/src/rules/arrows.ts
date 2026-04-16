import {
    rule,
    toKey,
    withModifier
} from "karabiner.ts";

export function viArrowsWithFn() {
  return rule("toggle h/j/k/l to arrow keys with fn").manipulators([
    withModifier(["fn"])({
      h: toKey("left_arrow"),
      j: toKey("down_arrow"),
      k: toKey("up_arrow"),
      l: toKey("right_arrow"),
    }),
  ]);
}
