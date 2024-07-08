![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=fff)

## `tmexcludes` - Manage Time Machine exclusions! 🔄

Fast, light [macOS] utility that shows, backups and restores the list of
files and folders you have excluded from [Time Machine]. These can also
be managed from the [Time Machine] pane of System Settings.

<div align="center">
  <img src="https://github.com/Neved4/tmexcludes/assets/63655535/69bd9283-e616-4338-9b2a-e43a8bb6cb04" alt="Image Description" style="width: 85%" />

  ###### _Catpuccin Mocha_ theme, _Menlo_ font.
</div>

## Motivation

[`tmexcludes`] allows extracting and manage Time Machine exclusions
independently of other settings, making it easier to sync multiple
workstations and add further processing in between the processes.

For example, one could automate certain tasks on specific folders, provided
they are in present in the list. [`tmexcludes`] streamlines the overall
workflow, making easier to maintain consistent settings across [macOS]
installs.

These _excluded paths_ are saved in
`/Library/Preferences/com.apple.TimeMachine.plist`, stored inside the
`SkipPaths` array. Running a basic `cp`, `mv` on the `.plist` file could take
care of backing up and restoring these settings.

Additionally, [macOS] provides an alternative way of managing with `defaults`:
```sh
# Store the .plist path into a variable
$ plist="/Library/Preferences/com.apple.TimeMachine.plist"

# Export our Time Machine settings
$ defaults export $plist TimeMachineConfig.plist

# Load our saved settings
$ defaults import $plist TimeMachineConfig.plist
```

## Highlights

- 🚀 _**Fast**_ - minimal overhead, [tmexcludes.sh][`tmexcludes`]
  only adds ~ `2.5 ms` of overhead.[^hyperfine]
- 🎨 _**Intuitive**_ - user-friendly, clear way to export and restore
  excluded [Time Machine] paths.
- 🔒 _**Robust**_ - ensures that the format passed to `defaults read` is a
  proper array.
- 📦 _**Self-contained**_ - no dependencies, lightweight, uses POSIX `sh`,
  `awk` (e.g. `1586 bytes`, `91 lines`).

## Getting Started

> [!NOTE]
> _**This utility is only intended to work in macOS.**_

If you have [`brew`] installed, just run:
```sh
$ brew install Neved4/tap/tmbackup
```

Otherwise, first clone the repo:
```sh
$ git clone https://github.com/Neved4/tmexcludes
```

### Usage

The following options are available:

```sh
usage: tmexcludes <command> ...

Commands:
  list        List current exclusions
  dump        Write exclusions to output
  load <file> Load excludes from file
  system      List built-in system excludes
```

## Examples

> [!WARNING]
> _**Always backup your settings first before modifying `defaults`.**_

List the exclusion settings:

```sh
$ ./tmexcludes.sh list
(
    "/opt/homebrew",
    "/usr/local/texlive"
)
```

Write all exclusion settings into output:
```sh
$ ./tmexcludes.sh dump > excludes.plist
(
    "/opt/homebrew",
    "/usr/local/texlive"
)
```

Restore the settings at a later point:
```sh
$ ./tmexcludes.sh load excludes.plist
```

Done!

## Standards

This script is compatible with [ISO 9945:2009][POSIX.1-2017],
also known as [POSIX.1-2017].[^posix-2017.1]

## License

This repository is licensed under the terms of the [MIT License][MIT License].

[^hyperfine]: Measured with [`hyperfine`].
[^posix-2017.1]: _IEEE Std 1003.1-2017: Standard for Information Technology_
    _— Portable Operating System Interface (POSIX®)_,
    ISO/IEC/IEEE 9945:2009/COR 2:2017.
    URL: https://pubs.opengroup.org/onlinepubs/9699919799/

[`tmexcludes`]: (src/tmexcludes.sh)
[`brew`]: https://brew.sh/
[`hyperfine`]: https://github.com/sharkdp/hyperfine
[macOS]: https://www.apple.com/macos/
[MIT License]: https://opensource.org/license/mit/
[POSIX.1-2017]: https://pubs.opengroup.org/onlinepubs/9699919799/
[Time Machine]: https://support.apple.com/en-gb/guide/mac-help/mh35860/14.0/mac/14.0
