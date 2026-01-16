# Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites

* `chezmoi` [installed on your machine](https://www.chezmoi.io/install/)

## Profiles

The profiles determine which packages to install when applying the dotfiles. You can find categories included in each profiles in `home/.chezmoidata/profiles.yaml`.

* `personal`: setup including all packages I find useful for my personal PC
* `work`: setup including useful packages for work (a subset of `personal`)
* `vps`: minimal setup including useful CLI packages

## Install

```sh
chezmoi init ArmandPhilippot
```

You'll be asked to fill in some information in order to apply the dotfiles and install the packages:
* the profile to load (to determine the packages to install)
* your full name (used with Git)
* the email you use with Git
* the GPG signing key to use with this email

## Philosophy

Why? For the same reasons described on: https://dotfiles.github.io/

> Why would I want my dotfiles on GitHub?
>
>* **_Backup_**, **_restore_**, and **_sync_** the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
>* **_Learn_** from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
>* **_Share_** what you’ve learned with the rest of us.

## Licenses

For most of the dotfiles, I don't see the interest to put them under a license so you can do whatever you want with them.

There are some exceptions:

* convto is licensed under the MIT license
* new-vhost is licensed under the MIT license
* fuzbat is only adapted by me so the credit goes to [Casey Brant](https://caseybrant.com/). I don't see a license but maybe I'm wrong.
* the various Git submodules include their own license:
    * [nvm](https://github.com/nvm-sh/nvm) is licensed under the MIT license
