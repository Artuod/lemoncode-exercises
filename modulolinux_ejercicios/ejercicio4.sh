#!/bin/bash
# Declaramos la url como una variable
url=https://lemoncode.net/

# Descargar el contenido de una página web a un fichero
curl -s $url > ficherotemporal.html

# Contamos cuantas palabras hay
numero_veces=$(grep -o -i  "$1" ficherotemporal.html | wc -l)

# Mostramos el resultado
if [ $numero_veces -eq 0 ]; then
  echo "No se ha encontrado la palabra \"$1\""
else
  echo "La palabra \"$1\" aparece $numero_veces veces"
 primera_linea=$(grep -m 1 -n "$1" ficherotemporal.html | cut -d ':' -f 1)
  echo "Aparece por primera vez en la línea $primera_linea"
fi