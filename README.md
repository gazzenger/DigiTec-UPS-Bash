# DigiTec-UPS-Bash
This program uses NUT
https://networkupstools.org
https://github.com/networkupstools/nut

As the Digitech UPS is not natively supported by NUT, the NUT packages must be rebuilt.

The following is taken from,
https://github.com/networkupstools/nut/wiki/Building-NUT-on-Debian,-Raspbian-and-Ubuntu
Along with a few modifications from,
https://github.com/networkupstools/nut/issues/674


1) make sure you have uncommented "deb-src" lines to match the "deb" lines in /etc/apt/sources*
```bash
deb-src http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi
```

1) run sudo apt-get update if you had to change any sources
1) run sudo apt-get build-dep nut
1) run sudo apt-get -y install git if you do not already have Git installed
1) clone the source to your working directory: git clone https://github.com/networkupstools/nut.git
1) cd nut
1) git remote add -f marianojan https://github.com/marianojan/nut.git
    git merge marianojan/hunnox-hnx850
    Fix any merge conflicts with drivers/Makefile.am, which i was able to clear up (add in the hunnox driver)
1) run ./autogen.sh
1) run this mega-command (this prepares the config):
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
1) run make
1) cd to /etc/nut/
1) Update the ups.conf with the following
```bash
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
```
1) cd ~/nut/drivers
1) run sudo make install
1) next run the following command to start the connection
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


