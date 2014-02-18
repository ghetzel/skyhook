Skyhook Mark III
================

A network bootable Linux live environment with an integrated masterless Chef client.


Overview
--------
The Mark III image is a Debian based live system built and managed by the Debian live-build suite of tools.  It has Opscode's Chef client pre-installed, as well as boot scripts that can retrieve cookbooks and configuration data from a remote source and apply them to the running node.

The image can be customized to suit your needs in accordance with the Debian live-build procedures.  Here is a quick overview of a few common tasks:

* **Packages:** The packages that will be installed in the image are defined in _config/package-lists/*.list_
* **Files:** Files can be inserted into the boot image by placing them into their full filesystem paths under _config/includes.chroot/_
* **Hooks:** Custom scripts can be run both during the image build and boot process by placing them in _config/hooks/_ as _*.chroot_ (build) or _*.binary_ (boot).  For example; _config/hooks/cleanup.chroot_ would execute while the image is being built on your machine, whereas _config/hooks/ping.binary_ would execute when the image is booted.


Prerequisites
-------------
* Tested on Ubuntu 12.10, but should build on any recent Ubuntu/Debian system
* `$ apt-get install debootstrap squashfs-tools live-build build-essential`

Build Instructions
------------------
```
$ make
```

If successful, resultant images will be in _binary/live_ as **vmlinuz** (kernel), **initrd.img** (initramfs), and **filesystem.squashfs** (the root filesystem image).


Using the Integrated Chef Environment
-------------------------------------
The image comes with Chef client preinstalled.  The _/usr/bin/chef-run_ script runs when the system boots and attempts to download and execute cookbooks and settings from sources configured in the kernel boot parameters.

The process starts by inspecting the kernel boot parameters so that _chef-run_ can locate _repositories_, which are tar-gzipped archives that contain a "chef-repo" directory structure.  Please refer to https://github.com/opscode/chef-repo for details regarding the layout of these directories.  Once the repositories are downloaded and extracted, a _runlist_ is used (either specified directly or as a URL containing the runlist via the `chef.runlist` kernel parameter).  This runlist determines the order in which the recipes downloaded from one or more repositories are executed.

Chef is an extremely powerful and versatile configuration management system that can perform just about any task you require of it.  If you would like to know more, consult the Chef documentation at http://docs.opscode.com/.


### Kernel Parameters

| Kernel Parameter   | Short Version | Example Value(s)                        | Description                                                                  |
| ------------------ | ------------- | --------------------------------------- | ---------------------------------------------------------------------------- |
| chef.skip          | nochef        | `true`, `false`                         | Specifies whether Chef should execute on boot or not (default: `false`)      |
| chef.repo          | repo          | `base,install,things`                   | A comma-separated list of repositories to download (suffixed with _.tar.gz_) |
| chef.baseurl       | repourl       | http://repo.example.com/chef/repos      | A URL that is prefixed to all repositories specified with `chef.repo`        |
| chef.runlist       | runlist       | `role[global],recipe[os::repo]`         | A comma-separated list of recipes that Chef should execute, in order         |
| chef.runlist       | runlist       | `http://repo.example.com/chef/run.list` | A URL that _chef-run_ will download a runlist file from                      |

### Runlist Files

If you specify a URL in the `chef.runlist` kernel parameter, _chef-run_ will download the contents of that URL and parse it for recipes to execute.  Here is an example file with valid syntax:

```
# Sample runlist file
# Comments are prefixed with '#' and are ignored

# So

# Are

# Blank Lines

role[base]

# other things
recipe[ntp]
recipe[nginx::server]

role[api-server]

```

The resultant runlist from the above file would be: `role[base],recipe[ntp],recipe[nginx::server],role[api-server]`


See Also
--------
* Debian _live-build_ Manual: http://live.debian.net/manual/current/html/live-manual.en.html
