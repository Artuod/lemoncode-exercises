#!/bin/bash
frase=$1
if [ -z $frase ]
then
    frase="Que me gusta la bash!!!!"
fi
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
echo $frase > foo/dummy/file1.txt

cat foo/dummy/file1.txt > foo/dummy/file2.txt
mv foo/dummy/file2.txt foo/empty/file2.txt