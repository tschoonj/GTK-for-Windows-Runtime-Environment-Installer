#!/bin/bash

# ---------------------------------------------------------------------------
# Set default values to option vars
# ---------------------------------------------------------------------------
set -e
set -x
INSTALL_SRC_DIR=$(dirname "$0")
INSTALL_SRC_MSYS2="/mingw64/"
_DATE=$(date +'%Y-%m-%d')
_VERSION="3.20.2"
_ARCH="win64"
# ---------------------------------------------------------------------------
# Check source directory and prepare binary and lib destination directory
# in the NSIS source tree
# ---------------------------------------------------------------------------

test "${INSTALL_SRC_DIR}" = "." && INSTALL_SRC_DIR=${PWD}
INSTALL_SRC_BIN="${INSTALL_SRC_DIR}"/bin
INSTALL_SRC_LIB="${INSTALL_SRC_DIR}"/lib
INSTALL_SRC_MSYS2_BIN=${INSTALL_SRC_MSYS2}/bin
INSTALL_SRC_MSYS2_LIB=${INSTALL_SRC_MSYS2}/lib
INSTALL_SRC_SSL="${INSTALL_SRC_DIR}"/ssl
INSTALL_SRC_MSYS2_SSL=${INSTALL_SRC_MSYS2}/ssl
INSTALL_SRC_ETC="${INSTALL_SRC_DIR}"/etc
INSTALL_SRC_MSYS2_ETC=${INSTALL_SRC_MSYS2}/etc

# Create installer file name
INSTALLER_FILENAME=gtk3-runtime-${_VERSION}-${_DATE}-${_ARCH}.msi

echo $INSTALLER_FILENAME

# ---------------------------------------------------------------------------
# Copy relevant GTK files to the binary destination directory
# ---------------------------------------------------------------------------

echo "Copying all GTK files from  : " $INSTALL_SRC_MSYS2
echo "    to NSIS source directory: " $INSTALL_SRC_BIN

cp $INSTALL_SRC_MSYS2_BIN/libatk-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libatkmm-1.6-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libcairo-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libcairo-gobject-2.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libcairo-script-interpreter-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libcairomm-1.0-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libssp-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libepoxy-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libexslt-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libffi-7.dll  $INSTALL_SRC_BIN 
cp $INSTALL_SRC_MSYS2_BIN/libfontconfig-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libfreetype-6.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libfribidi-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgailutil-3-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgailutil-18.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdk_pixbuf-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/liblzma-5.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libcroco-0.6-3.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdk-win32-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdk-3-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdkmm-3.0-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdkmm-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgio-2.0-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libglib-2.0-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libglibmm-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgiomm-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libsigc-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libglibmm_generate_extra_defs-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgmodule-2.0-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgobject-2.0-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgthread-2.0-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtk-3-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtk-win32-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtksourceview-3.0-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtksourceview-4-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtksourceview-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtksourceviewmm-3.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtkmm-3.0-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtkmm-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libharfbuzz-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libintl-8.dll $INSTALL_SRC_BIN

# I'm not sure that this is needed...:
cp $INSTALL_SRC_MSYS2_BIN/libiconv-2.dll $INSTALL_SRC_BIN

cp $INSTALL_SRC_MSYS2_BIN/libjson-glib-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpango-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpangocairo-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpangowin32-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpangoft2-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpangomm-1.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpixman-1-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpng16-16.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libthai-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libdatrie-1.dll  $INSTALL_SRC_BIN

# No need for this IMHO, at least fontconfig is not dependent on these
cp $INSTALL_SRC_MSYS2_BIN/libxml++-2.6-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libxml++-3.0-1.dll $INSTALL_SRC_BIN

cp $INSTALL_SRC_MSYS2_BIN/libxml2-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libxslt-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpcre-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/zlib1.dll $INSTALL_SRC_BIN

# These six additional one seems to me that is needed for my test GTK app,
# as I see mainly needed for fontconfig package and dlls 
cp $INSTALL_SRC_MSYS2_BIN/libexpat-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libbz2-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgraphite2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/librsvg-2-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libtiff-5.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libjasper-4.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libjpeg-8.dll $INSTALL_SRC_BIN

# libsoup and its dependencies
cp $INSTALL_SRC_MSYS2_BIN/libbrotlidec.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libbrotlicommon.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libsoup-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libsoup-gnome-2.4-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libsqlite3-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgnutls-30.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgmp-10.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libhogweed-6.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libnettle-8.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libidn2-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libp11-kit-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libtasn1-6.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libunistring-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libproxy-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpsl-5.dll $INSTALL_SRC_BIN

# libpeas
cp $INSTALL_SRC_MSYS2_BIN/libpeas-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpeas-gtk-1.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgirepository-1.0-1.dll $INSTALL_SRC_BIN
mkdir -p $INSTALL_SRC_LIB/libpeas-1.0/loaders
cp $INSTALL_SRC_MSYS2_LIB/libpeas-1.0/loaders/libpython3loader.dll $INSTALL_SRC_LIB/libpeas-1.0/loaders

# Standard MSYS2 libraries
cp $INSTALL_SRC_MSYS2_BIN/libstdc++-6.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgcc_s_seh-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libwinpthread-1.dll $INSTALL_SRC_BIN


cp $INSTALL_SRC_MSYS2_BIN/gdbus.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-cache.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-cat.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-list.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-match.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-pattern.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-query.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-scan.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/fc-validate.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gdk-pixbuf-query-loaders.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gspawn-win64-helper.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gspawn-win64-helper-console.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gtk-query-immodules-2.0.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gtk-query-immodules-3.0.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gtk-update-icon-cache.exe $INSTALL_SRC_BIN

# Copy lib/gtk-2.0 folder 
cd $INSTALL_SRC_MSYS2_LIB/gtk-2.0
cp -r ./ $INSTALL_SRC_LIB/gtk-2.0
# Delete static libraries
find $INSTALL_SRC_LIB/gtk-2.0 -name *.a -type f -delete

# Copy lib/gdk-pixbuf-2.0 folder 
cd $INSTALL_SRC_MSYS2_LIB/gdk-pixbuf-2.0
cp -r ./ $INSTALL_SRC_LIB/gdk-pixbuf-2.0
# Delete static libraries
find $INSTALL_SRC_LIB/gdk-pixbuf-2.0 -name *.a -type f -delete

# Copy lib/gio/modules folder 
cd $INSTALL_SRC_MSYS2_LIB/gio
mkdir -p $INSTALL_SRC_LIB/gio
cp -r modules $INSTALL_SRC_LIB/gio/
# Delete static libraries
find $INSTALL_SRC_LIB/gio/modules -name *.a -type f -delete

# Copy lib/girepository-1.0 folder 
cd $INSTALL_SRC_MSYS2_LIB/girepository-1.0
mkdir -p $INSTALL_SRC_LIB/girepository-1.0
cp -r *typelib $INSTALL_SRC_LIB/girepository-1.0/

# copy gtksourceview data files
rm -rf $INSTALL_SRC_DIR/share/gtksourceview-3.0
rm -rf $INSTALL_SRC_DIR/share/gtksourceview-4
cp -r $INSTALL_SRC_MSYS2/share/gtksourceview-3.0 $INSTALL_SRC_DIR/share/
cp -r $INSTALL_SRC_MSYS2/share/gtksourceview-4 $INSTALL_SRC_DIR/share/

# Copy /share/locale/locale.alias
rm -r $INSTALL_SRC_DIR/share/locale
cp -r $INSTALL_SRC_MSYS2/share/locale $INSTALL_SRC_DIR/share/

# Copy /share/themes/default
cp -r $INSTALL_SRC_MSYS2/share/themes/default/gtk-3.0 $INSTALL_SRC_DIR/share/themes/default/

# Copy /share/themes/emacs
cp -r $INSTALL_SRC_MSYS2/share/themes/emacs/gtk-3.0 $INSTALL_SRC_DIR/share/themes/emacs/

# Copy /share/glib-2.0/schemas
cp -r $INSTALL_SRC_MSYS2/share/glib-2.0/schemas $INSTALL_SRC_DIR/share/glib-2.0/

# Copy /share/icons
cp -r $INSTALL_SRC_MSYS2/share/icons $INSTALL_SRC_DIR/share/

# Copy SSL certificate bundle
mkdir -p $INSTALL_SRC_SSL/certs
cd $INSTALL_SRC_MSYS2_SSL/certs
cp ca-bundle.crt ca-bundle.trust.crt $INSTALL_SRC_SSL/certs/

# Copy fontconfig stuff (see issue #14)
mkdir -p $INSTALL_SRC_ETC/fonts
cd $INSTALL_SRC_MSYS2_ETC/fonts
cp -a * $INSTALL_SRC_ETC/fonts/


# librsvg depends on:
# gdk-pixbuf2  pango  libcroco

# gdk-pixbuf2 package depends on the following:
# glib2>=2.37.2  jasper libjpeg-turbo libpng  libtiff


echo "Done with copying all binary relevant GTK files to the binary destination directory"
echo "Now you can initiate the creation of the installer package with NSIS"
