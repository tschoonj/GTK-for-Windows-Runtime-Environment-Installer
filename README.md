GTK+ for Windows Runtime Environment Installer: 64-bit
======================================================

This repository is a fork of the  [GTK+ for Windows Runtime Environment Installer](http://gtk-win.sourceforge.net) that was originally created
by Alexander Shaduri.
My efforts here will focus on creating a **64-bit version** of the GTK+-2 runtime that he has been providing so far, using up to date versions of GTK+ and its dependencies. Recently I have also created a 64-bit **GTK+-3 runtime package**. All packages now contain **Gtkmm** and its dependencies too. Since the GTK+ developers recently dropped support for stock icons (a mistake of epic proportions IMHO...), I added the Adwaita icon theme to the GTK+-3 runtime, so you can still enjoy pretty filechooserdialogs etc! I have also added a couple of commonly used libraries such as libxml++, libxslt and gtksourceview.

The installers can be found in the [releases section](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases).

The current releases ([gtk2-runtime-2.24.31-2017-08-17-ts-win64.exe](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases/download/2017-08-17/gtk2-runtime-2.24.31-2017-08-17-ts-win64.exe) and [gtk3-runtime-3.22.18-2017-08-17-ts-win64.exe](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases/download/2017-08-17/gtk3-runtime-3.22.18-2017-08-17-ts-win64.exe)) were obtained entirely from the excellent [MSYS2 project](www.msys2.org), and were **not** compiled by myself, as was the case for releases made before 2017. Users who want to compile against this runtime are strongly encouraged to set up a MSYS2 installation themselves, and install the required packages (compiled with the mingw-w64-x86\_64 toolchain!!!).

The following packages are included in the current GTK+-2/3 installers

* [adwaita icon theme](http://ftp.gnome.org/pub/GNOME/sources/adwaita-icon-theme/) (3.24.0)
* [atk](http://ftp.gnome.org/pub/GNOME/sources/atk/) (2.24.0)
* [atkmm](http://ftp.gnome.org/pub/GNOME/sources/atkmm/) (2.24.2)
* [cairo](http://cairographics.org/releases/) (1.15.6)
* [cairomm](http://cairographics.org/releases/) (1.12.0)
* [fontconfig](http://www.freedesktop.org/software/fontconfig/release/) (2.12.4)
* [freetype](http://www.freetype.org/download.html) (2.8)
* [gdk-pixbuf](http://ftp.gnome.org/pub/GNOME/sources/gdk-pixbuf/) (2.36.6)
* [gettext](http://ftp.gnu.org/pub/gnu/gettext/) (0.19.8.1)
* [glib](http://ftp.gnome.org/pub/GNOME/sources/glib/) (2.52.3)
* [glibmm](http://ftp.gnome.org/pub/GNOME/sources/glibmm/) (2.50.0)
* [gtk2](http://ftp.gnome.org/pub/GNOME/sources/gtk+/) (2.24.31)
* [gtk3](http://ftp.gnome.org/pub/GNOME/sources/gtk+/) (3.22.18)
* [gtkmm2](http://ftp.gnome.org/pub/GNOME/sources/gtkmm) (2.24.4)
* [gtkmm3](http://ftp.gnome.org/pub/GNOME/sources/gtkmm) (3.22.0)
* [gtksourceview2](http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/) (2.10.5)
* [gtksourceview3](http://ftp.gnome.org/pub/GNOME/sources/gtksourceview/) (3.24.3)
* ~~[gtksourceviewmm2](http://ftp.gnome.org/pub/GNOME/sources/gtksourceviewmm/) (2.10.3)~~ (currently unavailable)
* [gtksourceviewmm3](http://ftp.gnome.org/pub/GNOME/sources/gtksourceviewmm/) (3.18.0)
* [harfbuzz](http://www.freedesktop.org/software/harfbuzz/release/) (1.4.8)
* [hicolor-icon-theme](http://icon-theme.freedesktop.org/releases/) (0.15)
* [json-glib](http://ftp.gnome.org/pub/gnome/sources/json-glib/) (1.2.8)
* [libepoxy](https://github.com/anholt/libepoxy) (1.4.3)
* [libffi](http://sourceware.org/libffi/) (3.2.1)
* [libiconv](https://ftp.gnu.org/pub/gnu/libiconv/) (1.15)
* [libpng](http://sourceforge.net/project/showfiles.php?group_id=5624) (1.6.31)
* [libsigc++](http://ftp.gnome.org/pub/GNOME/sources/libsigc++/) (2.10.0)
* [libxml2](http://xmlsoft.org/sources/) (2.9.4)
* [libxml++2](http://ftp.gnome.org/pub/GNOME/sources/libxml++/) (2.40.0)
* [libxml++3](http://ftp.gnome.org/pub/GNOME/sources/libxml++/) (3.0.0)
* [libxslt](http://xmlsoft.org/sources/) (1.1.29)
* [pango](http://ftp.gnome.org/pub/GNOME/sources/pango/) (1.40.6)
* [pangomm](http://ftp.gnome.org/pub/GNOME/sources/pangomm/) (2.40.0)
* [pcre](ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/) (8.41)
* [pixman](http://cairographics.org/releases/) (0.34.0)
* [zlib](http://www.zlib.net) (1.2.11)

For all other information regarding how to use the installer, the reader is kindly referred to [Alexander Shaduri's website](http://gtk-win.sourceforge.net) of the GTK for Windows runtime environment installer. The only difference with the installers found at his website is that mine DO NOT have the `compatdlls` option, but this should present no problems to any user.  

Personally I use this installer in my [XMI-MSIM project](http://github.com/xmimsim). You may want to have a look at my Inno Setup ([new](https://github.com/tschoonj/xmimsim/blob/master/windows/xmimsim.iss)) and NSIS ([old](https://github.com/tschoonj/xmimsim/blob/XMI-MSIM-4.0/nsis/xmimsim-win64.nsi.in)) based installers. 

Those interested in scientific plotting using Gtkmm3 may want to have a look at my project [Gtkmm-PLplot](https://github.com/tschoonj/gtkmm-plplot). Documentation and examples can be found [here](http://tschoonj.github.io/gtkmm-plplot)

If you have enjoyed using this project, please consider making a donation or buying something off my Amazon Wish list. 

[![PayPal](https://cdn.rawgit.com/twolfson/paypal-github-button/1.0.0/dist/button.svg)](https://www.paypal.me/tomschoonjans/10)

[![Amazon Wish list](http://manghammath.com/Link%20Icons%202015/Amazon_Wishlist.png)](http://amzn.eu/8ml3d0c)

Tom Schoonjans
