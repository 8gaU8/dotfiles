import { rule, toApp, withModifier } from "karabiner.ts";

const APPS = {
  Terminal: "Ghostty",
  Browser: "Arc",
  Editor: "Visual Studio Code",
  Note: "Notion",
  Keynote: "Keynote",
  Zotero: "Zotero",
};

export function launchApp() {
  return rule("Launch Apps").manipulators([
    withModifier(["command", "control"])({
      t: toApp(APPS.Terminal),
      s: toApp(APPS.Browser),
      x: toApp(APPS.Editor),
      n: toApp(APPS.Note),
      k: toApp(APPS.Keynote),
      z: toApp(APPS.Zotero),
    }),
  ]);
}
