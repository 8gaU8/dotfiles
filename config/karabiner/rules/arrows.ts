import {
  ifVar,
  map,
  rule,
  toKey,
  withMapper,
  withModifier,
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

export function magicArrows() {
  const ifTrackpadTouched = ifVar(
    "multitouch_extension_finger_count_total",
    0,
  ).unless();

  return rule("toggle h/j/k/l to arrow keys", ifTrackpadTouched).manipulators([
    withMapper({
      h: "left_arrow",
      j: "down_arrow",
      k: "up_arrow",
      l: "right_arrow",
    } as const)((key, arrow) =>
      map({ key_code: key })
        .to({ key_code: arrow })
        .description(`Tap ${key} to ${arrow}`),
    ),
  ]);
}
