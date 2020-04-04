# DigiTec-UPS-Bash


This program uses NUT
https://networkupstools.org
https://github.com/networkupstools/nut

To install (usually) run
```bash
sudo apt-get install nut
```


However for building from source code on debian
https://github.com/networkupstools/nut/wiki/Building-NUT-on-Debian,-Raspbian-and-Ubuntu


make sure you have uncommented "deb-src" lines to match the "deb" lines in /etc/apt/sources*
run sudo apt-get update if you had to change any sources
run sudo apt-get build-dep nut
optional: remove asciidoc (or install the build-deps manually, and omit asciidoc) to save a bit of build time
run sudo apt-get -y install git if you do not already have Git installed
clone the source to your working directory: git clone https://github.com/networkupstools/nut.git
cd nut and run ./autogen.sh

Create the config
```bash
./configure --includedir=/usr/include --mandir=/usr/share/man \
--infodir=/usr/share/info --sysconfdir=/etc/nut --localstatedir=/var \
--libexecdir=/usr/lib/nut --srcdir=. --enable-maintainer-mode \
--disable-silent-rules --libdir=/usr/lib/`gcc -print-multiarch` \
--with-ssl --with-nss --with-cgi --with-dev --enable-static \
--with-statepath=/var/run/nut --with-altpidpath=/var/run/nut \
--with-drvpath=/lib/nut --with-cgipath=/usr/lib/cgi-bin/nut \
--with-htmlpath=/usr/share/nut/www --with-pidpath=/var/run/nut \
--datadir=/usr/share/nut --with-pkgconfig-dir=/usr/lib/`gcc -print-multiarch`/pkgconfig \
--with-user=nut --with-group=nut --with-udev-dir=/lib/udev \
--with-systemdsystemunitdir=/lib/systemd/system
```

run make
You can either run the drivers from the source tree, or run sudo make install from the drivers directory to partially overwrite the contents of the NUT .deb files.

Create a ups.conf file in the config folder

For the Digitech UPS, following the guidance here
https://github.com/networkupstools/nut/issues/674

The ups.conf file should be
[myups]
  driver = "nutdrv_qx"
  desc = "DigiTech 650VA UPS"
  port = "auto"
  vendorid = "0001"
  productid = "0000"
  protocol = "hunnox"
  langid_fix = "0x0409"
  novendor
  noscanlangid

Ensure to have performed the following 


    git clone https://github.com/networkupstools/nut.git
    cd nut
    git remote add -f marianojan https://github.com/marianojan/nut.git
    git merge marianojan/hunnox-hnx850
    I had a conflict with the drivers/Makefile.am, which i was able to clear up (add in the hunnox driver)

To run the program, simply navigate to the drivers folder and run the command

```bash
./nutdrv_qx -a myups -DDDDD
```


To speed everything up, the script can be adapted to detect a drop in the voltage for starting the power down procedure.


## Found software is at the following location
http://www.apollotw.com//product-12/monitoring-software
http://www.apollotw.com/p-detail-15/upsmart-networking-v2.4.html
http://www.apollotw.com/p-detail-24/upsmart-dry-contact-v3.4.html


Other links
http://www.gruppidicontinuita.eu/softwares-2/upssmart/ (including UPSMon)
https://www.gembird.nl/service.aspx?item=5706

Other Software
WinPower, http://www.ups-software-download.com/
http://openupsmart.sourceforge.net/
http://www.tech-info.it/downloadsoftware.htm


