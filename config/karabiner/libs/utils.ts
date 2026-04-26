import process from "node:process";
import yargs from "yargs";

export function parseProfileArgs() {
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

  if (args.dryRun) return "--dry-run";
  else if (args.profile) return args.profile;

  throw new Error("Either --dry-run or --profile must be specified");
}
