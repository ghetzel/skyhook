Custom Local Packages
=====================

To install a custom package, simply copy it to the _config/packages.chroot/_ directory. Packages that are inside this directory will be automatically installed into the live system during build - you do not need to specify them elsewhere.  Packages must be named in the prescribed way. One simple way to do this is to use `dpkg-name`.

Using _packages.chroot_ for installation of custom packages has disadvantages:

* It is not possible to use secure APT.
* You must install all appropriate packages in the _config/packages.chroot/_ directory.
* It does not lend itself to storing Debian Live configurations in revision control.
