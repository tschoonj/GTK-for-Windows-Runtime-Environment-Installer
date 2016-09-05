#!/bin/sh

# ---------------------------------------------------------------------------
# Set default values to option vars
# ---------------------------------------------------------------------------

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
INSTALL_SRC_MSYS2_BIN=${INSTALL_SRC_MSYS2}/bin
INSTALL_SRC_MSYS2_LIB=${INSTALL_SRC_MSYS2}/lib

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
cp $INSTALL_SRC_MSYS2_BIN/libepoxy-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libexslt-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libffi-6.dll  $INSTALL_SRC_BIN 
cp $INSTALL_SRC_MSYS2_BIN/libfontconfig-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libfreetype-6.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgailutil-3-0.dll  $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdk_pixbuf-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdk-3-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdkmm-3.0-1.dll $INSTALL_SRC_BIN
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
cp $INSTALL_SRC_MSYS2_BIN/libgtksourceview-3.0-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtksourceviewmm-3.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgtkmm-3.0-1.dll $INSTALL_SRC_BIN
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

# No need for this IMHO, at least fontconfig is not dependent on these
# cp $INSTALL_SRC_MSYS2_BIN/libxml++-2.6-2.dll $INSTALL_SRC_BIN
# cp $INSTALL_SRC_MSYS2_BIN/libxml++-3.0-1.dll $INSTALL_SRC_BIN

cp $INSTALL_SRC_MSYS2_BIN/libxml2-2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libxslt-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libpcre-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/zlib1.dll $INSTALL_SRC_BIN

# These six additional one seems to me that is needed for my test GTK app,
# as I see mainly needed for fontconfig package and dlls 
cp $INSTALL_SRC_MSYS2_BIN/libgtk-win32-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgdk-win32-2.0-0.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libexpat-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libbz2-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgraphite2.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/librsvg-2-2.dll $INSTALL_SRC_BIN

# Standrard MSYS2 libraries
cp $INSTALL_SRC_MSYS2_BIN/libstdc++-6.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libgcc_s_seh-1.dll $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/libwinpthread-1.dll $INSTALL_SRC_BIN


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
cp $INSTALL_SRC_MSYS2_BIN/gtk-query-immodules-3.0.exe $INSTALL_SRC_BIN
cp $INSTALL_SRC_MSYS2_BIN/gtk-update-icon-cache.exe $INSTALL_SRC_BIN

# Should we also include libpixbufloader*. dll files under /lib/gdk-pixbuf-2.0, ie: libpixbufloader-svg.dll

echo "Done with copying all binary relevant GTK files to the binary destination directory"
echo "Now you can initiate the creation of the installer package with NSIS"