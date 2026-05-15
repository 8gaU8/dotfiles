import { map, type RuleBuilder, rule } from "karabiner.ts";

export function nbToFn(): RuleBuilder {
  return rule("NumPad → Fn").manipulators([
    map("1", "fn").to("f1"),
    map("2", "fn").to("f2"),
    map("3", "fn").to("f3"),
    map("4", "fn").to("f4"),
    map("5", "fn").to("f5"),
    map("6", "fn").to("f6"),
    map("7", "fn").to("f7"),
    map("8", "fn").to("f8"),
    map("9", "fn").to("f9"),
    map("0", "fn").to("f10"),
    map("hyphen", "fn").to("f11"),
    map("equal_sign", "fn").to("f12"),
  ]);
}

export function fnToMediaControl(): RuleBuilder {
  return rule("Fn → System").manipulators([
    // メディアコントロール
    map("a", "fn").to("play_or_pause"),
    map("s", "fn").to("vk_consumer_previous"),
    map("d", "fn").to("vk_consumer_next"),

    // 画面明るさ
    map("i", "fn").to("display_brightness_decrement"),
    map("o", "fn").to("display_brightness_increment"),

    // キーボードのバックライト（もしあれば）
    map("k", "fn").to("illumination_decrement"),
    map("l", "fn").to("illumination_increment"),

    // 音量
    map("f", "fn").to("mute"),
    map("g", "fn").to("volume_decrement"),
    map("h", "fn").to("volume_increment"),
  ]);
}
