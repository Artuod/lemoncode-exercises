#!/bin/bash
# Declaramos la url como una variable
url=$1
palabra=$2
echo "Bajaremos la url: $url"
if [ "$#" -eq "2" ] 
then 
    # Descargar el contenido de una página web a un fichero
    curl -s $url > ficherotemporal.html

    # Contamos cuantas palabras hay
    numero_veces=$(grep -o -i  "$palabra" ficherotemporal.html | wc -l)

    # Mostramos el resultado
    if [ $numero_veces -eq 0 ]; then
      echo "No se ha encontrado la palabra \"$palabra\""
    else
      echo "La palabra \"$palabra\" aparece $numero_veces veces"
    primera_linea=$(grep -m 1 -n "$palabra" ficherotemporal.html | cut -d ':' -f 1)
      echo "Aparece por primera vez en la línea $primera_linea"
    fi
else
  echo "Se necesitan únicamente dos parámetros para ejecutar este script"
fi