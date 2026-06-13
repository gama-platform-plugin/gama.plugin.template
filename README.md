# ⚠️ This is a template repo — follow the steps below before writing any code


## Step 0 - fork the template

Before doing anything, do not work on the original template repository, you must first fork it into your own repositories (or this organisation if you have the rights).
Find an appropriate name for the forked repository that will match the name of the plugin.

## Step 1 - Run the initialization workflow

Go to **Actions → Initialize plugin from template → Run workflow** and fill in:

| Field | Example |
|---|---|
| Plugin bundle ID | `gama.plugin.flooding` |
| Human-readable name | `Flooding Simulation` |

This will rename all placeholder files and directories to match your plugin, then commit the result. No local setup needed.

> The plugin ID must have exactly 3 dot-separated parts, e.g. `org.example.myplugin`.

---

## Step 2 — Pull the init commit and start coding

```bash
git pull
```

Your plugin is now in `gama.plugin.yourplugin/` with a working `MySkill.java` as a starting point.

Open the project in Eclipse as a standard Maven/Tycho project.

---

## Step 3 — Delete this README and write your own

This file is template boilerplate. Replace it with documentation about your plugin.

---

## How the CI works

- Pushing to `main` builds the plugin and deploys it to the GAMA plugin p2 site.
- The version and deploy path are derived automatically from the branch name (`GAMA_YYYY-MM`).
- On successful deploy, the composite p2 repository is updated automatically — your plugin becomes installable from Eclipse immediately.
