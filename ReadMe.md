﻿# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-insomnia-dotnet@b0f425b1edec3fe1ef231bc6570a23adc7ec5405/insomnia.png" width="48" height="48"/> Chocolatey Package: [Insomnia (.NET)](https://community.chocolatey.org/packages/insomnia-dotnet)

[![Chocolatey package version](https://img.shields.io/chocolatey/v/insomnia-dotnet.svg)](https://community.chocolatey.org/packages/insomnia-dotnet)
[![Chocolatey package download count](https://img.shields.io/chocolatey/dt/insomnia-dotnet.svg)](https://community.chocolatey.org/packages/insomnia-dotnet)

## Install

[Install Chocolatey](https://chocolatey.org/install), and run the following command to install the latest approved version on the Chocolatey Community Repository:

```shell
choco install insomnia-dotnet
```

Alternatively, the packages as published on the Chocolatey Community Repository will also be mirrored on this repository's [Releases page](https://github.com/brogers5/chocolatey-package-insomnia-dotnet/releases). The `nupkg` can be installed from the current directory (with dependencies sourced from the Community Repository) as follows:

```shell
choco install insomnia-dotnet -source="'.;https://community.chocolatey.org/api/v2/'"
```

## Build

[Install Chocolatey](https://chocolatey.org/install) and the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au), then clone this repository.

Once cloned, simply run `build.ps1`. The ZIP archive is intentionally untracked to avoid bloating the repository, so the script will download the Insomnia portable ZIP archive from the mirror created by this package (to ensure reproducibility in case of an older version), then packs everything together.

A successful build will create `insomnia-dotnet.w.x.y.z.nupkg`, where `w.x.y.z` should be the Nuspec's `version` value at build time.

Note that Chocolatey package builds are non-deterministic. Consequently, an independently built package will fail a checksum validation against officially published packages.

## Update

This package has an update script implemented with the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au), but the project does not appear to be actively maintained anymore, so it is not included with my normally scheduled update runs. If the project has a new release, please [open an issue](https://github.com/brogers5/chocolatey-package-insomnia-dotnet/issues).

AU expects the parent directory that contains this repository to share a name with the Nuspec (`insomnia-dotnet`). Your local repository should therefore be cloned accordingly:

```shell
git clone git@github.com:brogers5/chocolatey-package-insomnia-dotnet.git insomnia-dotnet
```

Alternatively, a junction point can be created that points to the local repository (preferably within a repository adopting the [AU packages template](https://github.com/majkinetor/au-packages-template)):

```shell
mklink /J insomnia-dotnet ..\chocolatey-package-insomnia-dotnet
```

Once created, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available. This will also build a new package version using the modified files.

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) using the [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.

