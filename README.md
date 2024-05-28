![Logo](work/core/assets-raw/sprites/ui/logo.png)

### MindustryX Client
* More Api for `mods`
* Better performance
* Better Quality-of-Life(QoL)
* Compatible with official client
* More aggressive bug fixing and experience new feature.(Release more frequently than the upstream)

### Version rule
Like `2024.05.25.238-client-wz` means `{date}.{code}-{branch}`, `code` increment each ci build.

### Commit Tag
* Type
  * O: Optimize performance
  * F: Added Feature
  * API: no effect, pure api for mod/plugin.
  * UI: Added ui element(implicit FC)
  * FIX: Fix bug
* Zone
  * S: server only change.
  * C: client only change.
  * BUILD: build time change, not runtime
* None tag means not game change.
* Can Combine Like `OC` `FS` `FC&UI`

### Features
See `./patches/`.

## Contribution
1. execute `scripts/applyPatches` then work in `work/`
2. commit your feature in `work/`, then `scripts/genPatches.sh` and commit in root.