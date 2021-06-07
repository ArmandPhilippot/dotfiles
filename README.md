# Dotfiles

This repo contains my personal configuration for Manjaro Linux.

## Why?

For the same reasons described on: https://dotfiles.github.io/

> Why would I want my dotfiles on GitHub?
>
>* **_Backup_**, **_restore_**, and **_sync_** the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
>* **_Learn_** from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
>* **_Share_** what you’ve learned with the rest of us.

## Structure

The dotfiles reside in the `home` directory of this repository.

I try to comply to the [XDG Base Directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) as much as possible. This way, I can minimize the amount of files in `$HOME`.

|XDG|Path|Description|
|---|---|---|
|`XDG_BIN_HOME`|`~/.local/bin`|Binaries (Unofficial)|
|`XDG_CACHE_HOME`|`~/.cache`|Cache|
|`XDG_CONFIG_HOME`|`~/.config`|Config|
|`XDG_DATA_HOME`|`~/.local/share`|Data|
|`XDG_LIB_HOME`|`~/.local/lib`|Libraries (Unofficial)|

The unofficial variables come from:
* The [Home directory hierarchy](https://www.freedesktop.org/software/systemd/man/file-hierarchy.html#Home%20Directory)
* many projects that use these names too.

## Features

### Config

* Code - OSS (VS Code) settings and keybindings
* Git
* Shell config (especially ZSH)

### Binaries

* `new-vhost` to quickly create a new virtual host with local cert on Manjaro

## Installation

At this time, I do not have a script to automate the process. Why? I can't decide which tools I want to use to facilitate my dotfiles management. I mostly hesitate between a personal script or a solution like GNU Stow.

## Acknowledgment

I was inspired by:
* [@Phantas0s](https://github.com/Phantas0s) and his article about [ZSH without Oh My Zsh](https://thevaluable.dev/zsh-install-configure-mouseless/)
* [@ayekat's dotfiles](https://github.com/ayekat/dotfiles)

## Disclaimer

Compatibility with other operating systems than Manjaro is not assured at this time (not tested).
