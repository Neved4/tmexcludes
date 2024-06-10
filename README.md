![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=fff)

## `tmexcludes` - Manage Time Machine exclusions! 🔄

Fast, light [macOS] utility that shows, backups and restores
the list of excludes in [Time Machine]'s System Preferences.

## Motivation

Thse excluded paths are stored in
`/Library/Preferences/com.apple.TimeMachine.plist` within the `SkipPaths`
array. Running a basic `cp` and `mv` on the `.plist` file can take care of
backing up and restoring these settings.

[`tmexcludes`] was made to extract and manage these exclusions, making it
easier to perofrm intermediate steps. With this in mind, one could, let's
say, automate certain tasks on specific folders if they are in present in
the list. This utility streamlines the overall process, making easier to
maintain consistent settings across [macOS] installations.

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
> _This utility is only intended to work in macOS._

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
