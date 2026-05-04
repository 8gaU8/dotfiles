import { rule, toApp, withModifier } from "karabiner.ts";

const APPS = {
  Terminal: "Ghostty",
  Browser: "Arc",
  Editor: "Visual Studio Code",
  Note: "Notion",
  Keynote: "Keynote",
  Preview: "Preview",
  Zotero: "Zotero",
  AI: "Gemini",
  Slack: "Slack",
};

export function launchApp() {
  return rule("Launch Apps").manipulators([
    withModifier(["command", "control"])({
      a: toApp(APPS.AI),
      t: toApp(APPS.Terminal),
      s: toApp(APPS.Browser),
      x: toApp(APPS.Editor),
      n: toApp(APPS.Note),
      k: toApp(APPS.Keynote),
      p: toApp(APPS.Preview),
      z: toApp(APPS.Zotero),
      e: toApp(APPS.Slack),
    }),
  ]);
}
