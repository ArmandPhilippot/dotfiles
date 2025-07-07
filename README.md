# Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Install

```sh
chezmoi init ArmandPhilippot
```

## Binaries

The `install-pkg` script at the repository root allows me to install all the packages that I use frequently. It also creates missing directories to be XDG compliant.

In `./home/xdg_bin`:

* `convto`: to quickly convert all files in the current directory (different operations are supported)
* `dotig`: my dotfiles manager
* `fuzbat`: used as a note-taking app from terminal
* `new-vhost`: to quickly create a new virtual host with a local cert on Manjaro
* `schemer2`: generate a color palette from a source image

## Philosophy

### Why?

For the same reasons described on: https://dotfiles.github.io/

> Why would I want my dotfiles on GitHub?
>
>* **_Backup_**, **_restore_**, and **_sync_** the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
>* **_Learn_** from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
>* **_Share_** what you’ve learned with the rest of us.

### Structure

The dotfiles reside in the `home` directory of this repository.

I try to comply to the [XDG Base Directory specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) as much as possible to limit the amount of files in `$HOME`. I'm also using some unofficial XDG variables following the [Home directory hierarchy](https://www.freedesktop.org/software/systemd/man/file-hierarchy.html#Home%20Directory).

|Var|Repo|Linux|Description|
|---|---|---|---|
|`HOME`|`./home`|`~/`|Other files in `$HOME`|
|`XDG_BIN_HOME`|`./home/dot_bin/`|`~/.local/bin`|Binaries (Unofficial)|
|`XDG_CACHE_HOME`|`./home/dot_cache/`|`~/.cache`|Cache|
|`XDG_CONFIG_HOME`|`./home/dot_config/`|`~/.config`|Config|
|`XDG_DATA_HOME`|`./home/dot_data/`|`~/.local/share`|Data|
|`XDG_LIB_HOME`|`./home/dot_lib/`|`~/.local/lib`|Libraries (Unofficial)|
|`XDG_STATE_HOME`|`./home/dot_state/`|`~/.local/state`|State|

## Licenses

For most of the dotfiles, I don't see the interest to put them under a license so you can do whatever you want with them.

There are some exception:

* convto is licensed under the MIT license
* new-vhost is licensed under the MIT license
* fuzbat is only adapted by me so the credit goes to [Casey Brant](https://caseybrant.com/). I don't see a license but maybe I'm wrong.
* schemer2 is not mine so the credit goes to [Daniel Byron](https://github.com/thefryscorer/schemer2). Again, I don't see a license but maybe I'm wrong.
* the various Git submodules include their own license:
    * [nvm](https://github.com/nvm-sh/nvm) is licensed under the MIT license
