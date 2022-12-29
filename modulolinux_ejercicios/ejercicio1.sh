#!/bin/bash

# Borramos primero todo por si lo ejecutamos varias veces
rm -R foo
# Creamos las carpetas
mkdir foo
mkdir foo/dummy
mkdir foo/empty
# Creamos los ficheros
touch foo/dummy/file1.txt
touch foo/dummy/file2.txt
# Guardamos el texto en el fichero
echo "Me encanta la bash!!" > foo/dummy/file1.txt