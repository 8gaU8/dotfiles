import process from "node:process";
import yargs from "yargs";

export function parseProfileArgs(profile: string) {
  const args = yargs(process.argv.slice(2))
    .option("dryRun", {
      alias: "d",
      type: "boolean",
      description: "Run in dry-run mode without applying changes",
    })
    .option("profile", {
      alias: "p",
      type: "string",
      description: "Specify the profile to modify",
    })
    .parseSync();

  if (args.dryRun) profile = "--dry-run";
  else if (args.profile) profile = args.profile;

  return profile;
}
