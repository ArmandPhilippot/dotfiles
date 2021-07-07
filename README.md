# Dotfiles

This repo contains my personal dotfiles.

## Why?

For the same reasons described on: https://dotfiles.github.io/

> Why would I want my dotfiles on GitHub?
>
>* **_Backup_**, **_restore_**, and **_sync_** the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
>* **_Learn_** from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
>* **_Share_** what you’ve learned with the rest of us.

## Structure

The dotfiles reside in the `home` directory of this repository.

I try to comply to the [XDG Base Directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) as much as possible to limit the amount of files in `$HOME`.

I use [Dotig](https://github.com/ArmandPhilippot/dotig) to managed my dotfiles. It is a script written by myself that use XDG paths.

|XDG|Repo|`$HOME` (based on XDG settings)|Description|
|---|---|---|---|
|`XDG_BIN_HOME`|`./home/xdg_bin/`|`~/.local/bin`|Binaries (Unofficial)|
|`XDG_CACHE_HOME`|`./home/xdg_cache/`|`~/.cache`|Cache|
|`XDG_CONFIG_HOME`|`./home/xdg_config/`|`~/.config`|Config|
|`XDG_DATA_HOME`|`./home/xdg_data/`|`~/.local/share`|Data|
|`XDG_LIB_HOME`|`./home/xdg_lib/`|`~/.local/lib`|Libraries (Unofficial)|
|`XDG_STATE_HOME`|`./home/xdg_state/`|`~/.local/state`|State|
||`./home`|`~/`|Other files in `$HOME`|

The unofficial variables come from:
* The [Home directory hierarchy](https://www.freedesktop.org/software/systemd/man/file-hierarchy.html#Home%20Directory)
* many projects that use these names too.

I do not backup all the dotfiles, so it is more likely that `XDG_CACHE_HOME` and `XDG_STATE_HOME` are missing from this repo.

## Binaries

* `dotig`: my dotfiles manager
* `fuzbat`: used as a note-taking app from terminal
* `new-vhost`: to quickly create a new virtual host with a local cert on Manjaro

## Acknowledgment

I was inspired by:
* [@Phantas0s](https://github.com/Phantas0s) and his article about [ZSH without Oh My Zsh](https://thevaluable.dev/zsh-install-configure-mouseless/)
* [@ayekat's dotfiles](https://github.com/ayekat/dotfiles)

## Licenses

For most of the dotfiles, I don't see the interest to put them under a license so you can do whatever you want with them.

There are some exception:

* Dotig is licensed under the MIT license
* new-vhost is licensed under the MIT license
* fuzbat is only adapted by me so the credit goes to [Casey Brant](https://caseybrant.com/). I don't see a license but maybe I'm wrong.
* the various Git submodules include their own license:
    * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) is licensed under the BSD 3-Clause "New" or "Revised" License
    * [zsh-nvm](https://github.com/lukechilds/zsh-nvm) is licensed under  the MIT license
