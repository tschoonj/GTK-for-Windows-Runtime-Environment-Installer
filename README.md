GTK+ for Windows Runtime Environment Installer: 64-bit
======================================================

This repository is a fork of the  [GTK+ for Windows Runtime Environment Installer](http://gtk-win.sourceforge.net) that was originally created
by Alexander Shaduri.
My efforts here will focus on creating a **64-bit version** of the runtime that he has been providing so far, using up to date versions of GTK+ and its dependencies.

The installers can be found [here](http://lvserver.ugent.be/gtk-win64/).

**[Keep in mind though that these packages are experimental. Binary compatibility between versions is not guaranteed!!!.](http://www.gtk.org/download/win64.php)** 

Both for convencience as well as for increased reliability across installations, it is recommended for developers to compile and link against the GTK+ SDK that I used to create the installers. This SDK can also be obtained at the aforementioned url.

The current release (gtk2-runtime-2.24.24-2014-09-28-ts-win64.exe) has been compiled using GCC 4.8.1 (MinGW-w64 installed from TDM-GCC).
The included GTK+ dependencies were selected according to the flowchart used by [Hexchat](http://hexchat.github.io/gtk-win32/). The source tarballs can be obtained by clicking on the names of the dependencies in the following list:

* [atk](http://ftp.gnome.org/pub/GNOME/sources/atk/) (2.14.0)
* [cairo](http://cairographics.org/releases/) (1.12.16)
* [fontconfig](http://www.freedesktop.org/software/fontconfig/release/) (2.11.1)
* [freetype](http://www.freetype.org/download.html) (2.5.3)
* [gdk-pixbuf](http://ftp.gnome.org/pub/GNOME/sources/gdk-pixbuf/) (2.31.1)
* [gettext](http://ftp.gnu.org/pub/gnu/gettext/) (0.19.2)
* [glib](http://ftp.gnome.org/pub/GNOME/sources/glib/) (2.42.0)
* [gtk](http://ftp.gnome.org/pub/GNOME/sources/gtk+/) (2.24.24)
* [harfbuzz](http://www.freedesktop.org/software/harfbuzz/release/) (0.9.35)
* [libffi](http://sourceware.org/libffi/) (3.1)
* [libpng](http://sourceforge.net/project/showfiles.php?group_id=5624) (1.6.13)
* [libxml2](http://xmlsoft.org/sources/) (2.9.1)
* [pango](http://ftp.gnome.org/pub/GNOME/sources/pango/) (1.36.8)
* [pixman](http://cairographics.org/releases/) (0.32.6)
* [win-iconv](http://code.google.com/p/win-iconv/downloads/list) (0.0.6)
* [zlib](http://www.zlib.net) (1.2.8)

For all other information regarding how to use the installer, the reader is kindly referred to the [Alexander Shaduri's website](http://gtk-win.sourceforge.net) of the GTK for Windows runtime environment installer. The only difference with the installers found at this website is that mine DO NOT have the `compatdlls` option, but this should present no problems to any user.  

Personally I use this installer in my [XMI-MSIM project](http://github.com/xmimsim). You may want to have a look at my Inno Setup ([new](https://github.com/tschoonj/xmimsim/blob/master/nsis/xmimsim.iss)) and NSIS ([old](https://github.com/tschoonj/xmimsim/blob/XMI-MSIM-4.0/nsis/xmimsim-win64.nsi.in)) based installers. 


Tom Schoonjans
