#! /bin/sh

echo "Building configure..."
autoreconf --install

rm -f config.cache

echo
echo 'run "./configure ; make ; make install"'
echo

