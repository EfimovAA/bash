#!/bin/bash

# ignores if some unaviable

MODS=( bcmath
cli
common
curl
fpm
gd
gmp
imagick
intl
json
mbstring
opcache
readline
sqlite3
xml
zip )

for MOD in ${MODS[@]}
    do
        apt install -y php-${MOD}
    done
