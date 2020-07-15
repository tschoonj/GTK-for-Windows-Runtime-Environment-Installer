GTK+ for Windows Runtime Environment Installer: 64-bit
======================================================

[![Github Downloads All Releases](https://img.shields.io/github/downloads/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/total.svg)](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases)
   [![PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/tomschoonjans/10)   [![Amazon Wish list](https://img.shields.io/badge/Amazon-Wishlist-green.svg)](http://amzn.eu/8ml3d0c)

This repository is a fork of the  [GTK+ for Windows Runtime Environment Installer](http://gtk-win.sourceforge.net) that was originally created
by Alexander Shaduri.
My efforts here will focus on creating a **64-bit version** of the GTK+-2 runtime that he has been providing so far, using up to date versions of GTK+ and its dependencies. Recently I have also created a 64-bit **GTK+-3 runtime package**. All packages now contain **Gtkmm** and its dependencies too. Since the GTK+ developers recently dropped support for stock icons (a mistake of epic proportions IMHO...), I added the Adwaita icon theme to the GTK+-3 runtime, so you can still enjoy pretty filechooserdialogs etc! I have also added a couple of commonly used libraries such as libxml++, libxslt, gtksourceview, libsoup and sqlite.

The installers can be found in the [releases section](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases).

The current releases ([gtk2-runtime-2.24.32-2020-07-15-ts-win64.exe](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases/download/2020-07-15/gtk2-runtime-2.24.32-2020-07-15-ts-win64.exe) and [gtk3-runtime-3.24.20-2020-07-15-ts-win64.exe](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases/download/2020-07-15/gtk3-runtime-3.24.20-2020-07-15-ts-win64.exe)) were obtained entirely from the excellent [MSYS2 project](https://www.msys2.org), and were **not** compiled by myself, as was the case for releases made before 2017. Users who want to compile against this runtime are strongly encouraged to set up a MSYS2 installation themselves, and install the required packages (compiled with the mingw-w64-x86\_64 toolchain!!!).

The following packages are included in the current GTK+-2/3 installers

* [adwaita icon theme](http://ftp.gnome.org/pub/GNOME/sources/adwaita-icon-theme/) (3.36.0)
* [atk](http://ftp.gnome.org/pub/GNOME/sources/atk/) (2.36.0)
* [atkmm](http://ftp.gnome.org/pub/GNOME/sources/atkmm/) (2.28.0)
* [cairo](http://cairographics.org/releases/) (1.16.0)
* [cairomm](http://cairographics.org/releases/) (1.12.2)
* [fontconfig](http://www.freedesktop.org/software/fontconfig/release/) (2.13.92)
* [freetype](http://www.freetype.org/download.html) (2.10.2)
* [gdk-pixbuf](http://ftp.gnome.org/pub/GNOME/sources/gdk-pixbuf/) (2.40.0)
* [gettext](http://ftp.gnu.org/pub/gnu/gettext/) (0.19.8.1)
* [glib](http://ftp.gnome.org/pub/GNOME/sources/glib/) (2.64.3)
* [glib-networking](http://ftp.gnome.org/pub/GNOME/sources/glib-networking/) (2.64.2)
* [glibmm](http://ftp.gnome.org/pub/GNOME/sources/glibmm/) (2.64.2)
* [gobject-introspection](http://ftp.gnome.org/pub/GNOME/sources/gobject-introspection/) (1.64.1)
* [gtk2](http://ftp.gnome.org/pub/GNOME/sources/gtk+/) (2.24.32)
* [gtk3](http://ftp.gnome.org/pub/GNOME/sources/gtk+/) (3.24.20)
* [gtkmm2](http://ftp.gnome.org/pub/GNOME/sources/gtkmm) (2.24.5)
* [gtkmm3](http://ftp.gnome.org/pub/GNOME/sources/gtkmm) (3.24.2)
* [gtksourceview2](http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/) (2.10.5)
* [gtksourceview3](http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/) (3.24.11)
* [gtksourceview4](http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/) (4.6.0)
* ~~[gtksourceviewmm2](http://ftp.gnome.org/pub/GNOME/sources/gtksourceviewmm/) (2.10.3)~~ (currently unavailable)
* [gtksourceviewmm3](http://ftp.gnome.org/pub/GNOME/sources/gtksourceviewmm/) (3.21.3)
* [harfbuzz](http://www.freedesktop.org/software/harfbuzz/release/) (2.6.8)
* [hicolor-icon-theme](http://icon-theme.freedesktop.org/releases/) (0.17)
* [json-glib](http://ftp.gnome.org/pub/gnome/sources/json-glib/) (1.4.4)
* [libepoxy](https://github.com/anholt/libepoxy) (1.5.4)
* [libffi](http://sourceware.org/libffi/) (3.3)
* [libiconv](https://ftp.gnu.org/pub/gnu/libiconv/) (1.16)
* [libpeas](http://ftp.gnome.org/pub/gnome/sources/libpeas/) (1.26.0)
* [libpng](http://sourceforge.net/project/showfiles.php?group_id=5624) (1.6.37)
* [librsvg](http://ftp.gnome.org/pub/GNOME/sources/librsvg/) (2.48.7)
* [libsigc++](http://ftp.gnome.org/pub/GNOME/sources/libsigc++/) (2.10.3)
* [libsoup](http://ftp.gnome.org/pub/GNOME/sources/libsoup/) (2.70.0)
* [libxml2](http://xmlsoft.org/sources/) (2.9.10)
* [libxml++2](http://ftp.gnome.org/pub/GNOME/sources/libxml++/) (2.40.1)
* [libxml++3](http://ftp.gnome.org/pub/GNOME/sources/libxml++/) (3.2.0)
* [libxslt](http://xmlsoft.org/sources/) (1.1.34)
* [pango](http://ftp.gnome.org/pub/GNOME/sources/pango/) (1.43.0)
* [pangomm](http://ftp.gnome.org/pub/GNOME/sources/pangomm/) (2.42.1)
* [pcre](ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/) (8.44)
* [pixman](http://cairographics.org/releases/) (0.40.0)
* [sqlite](https://www.sqlite.org) (3.32.3)
* [zlib](http://www.zlib.net) (1.2.11)

For all other information regarding how to use the installer, the reader is kindly referred to [Alexander Shaduri's website](http://gtk-win.sourceforge.net) of the GTK for Windows runtime environment installer. The only difference with the installers found at his website is that mine DO NOT have the `compatdlls` option, but this should present no problems to any user.  

Personally I use this installer in my [XMI-MSIM project](http://github.com/tschoonj/xmimsim). You may want to have a look at my Inno Setup ([new](https://github.com/tschoonj/xmimsim/blob/master/windows/xmimsim.iss)) and NSIS ([old](https://github.com/tschoonj/xmimsim/blob/XMI-MSIM-4.0/nsis/xmimsim-win64.nsi.in)) based installers. 

Those interested in scientific plotting using Gtkmm3 may want to have a look at my project [Gtkmm-PLplot](https://github.com/tschoonj/gtkmm-plplot). Documentation and examples can be found [here](http://tschoonj.github.io/gtkmm-plplot)

If you have enjoyed using this project, please consider making a donation or buying something off my Amazon Wish list. 

Tom Schoonjans
