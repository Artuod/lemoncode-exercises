###### EJERCICIO 1 ########

#### Network ####

# Para crear la red lemoncode-challenge haremos lo siguiente , esto es para modo local y no con docker-compose, ya que con docker-compose veremos que es capaz de crearlo en tiempo de ejecucion indicandolo
docker network create -d bridge lemoncode-challenge

#### Mongo #####
# Cambiamos el hosts local para que sepa interpretar el hostname de some-mongo para la base de datos, yo tengo un mac asi que seria
sudo nano /private/etc/hosts
127.0.0.1 some-mongo

# Para levantar el docker de mongo con volumen en data/db escribimos 
docker run --name=some-mongo --network lemoncode-challenge --publish "27017:27017" --hostname some-mongo --mount type=bind,source="$(pwd)"/data/db,target=/data/db -d mongo:latest

# Datos
Crearemos con compass mongo, datos, primero creamos la database y luego la colecction, y luego introducimos los datos con json tal como indica el ejercicio.

#### Backend ####

# Creamos la imagen de nuestro docker backend
docker build --pull --rm -f "backend/Dockerfile" -t lemoncode-topics-api:latest "backend"
# Ejecutamos el docker
docker run --publish 5001:5000 --network lemoncode-challenge  --hostname topics-api -d lemoncode-topics-api

#### FrontEnd ####

# Creamos la imagen de nuestro docker frontend
docker build --pull --rm -f "frontend/Dockerfile" -t lemoncode-frontend:latest "frontend"
# Ejecutamos el docker
docker run --publish 8080:3000 --network lemoncode-challenge -d lemoncode-frontend 


#### EJERCICIO 2 #####

Teniendo los dockerfile de cada proyecto

## Modificaciones en el proyecto FrontEnd para que funcione, dado que esta mal el uso de una variable
## Lo que se ha cambiado es en la linea 26 del fichero index.ejs, tenia el valor topic.topicName, pero el que funciona es topic.Name

## Creacion del contenedor con las 3 imagenes, los datos seran compuestos entre los Dockerfile y el propio docker-compose
docker compose up -d 

## Para parar los contenedores
docker compose kill

## Para borrar el container, nos situamos en la carpeta de nuestro proyecto
docker compose down 


## Borrado de las images
docker rmi $(docker images --filter=reference="*lemoncode-challenge*" -q)



###### EXTRA #######
## Si quisieramos crear la base de datos al crear el container, deberiamos agregar info adicional al docker-compose, y crear otro proyecto auxiliar de mongo que se conecte y introduzca los datos, los pasos serian para ese caso:

# 1. Agregamos a docker-compose.yml lo siguiente
mongo-seed:
    build:
      context: ./mongo-seed
      dockerfile: ./Dockerfile
    networks:
      - lemoncode-challenge
    depends_on:
    - some-mongo

# 2. Creamos en la ruta junto a backend y frontend, una nueva que sea "mongo-seed" , dentro habra un fichero Dockerfile y un init.json

# Dockefile de mongo-seed
FROM mongo
COPY init.json /init.json
CMD mongoimport --host some-mongo --db TopicstoreDb --collection Topics --type json --file /init.json --jsonArray

# Init.json
[
    {
    "_id": "5fa2ca6abe7a379ec4234883",
    "Name":"Contenedores"
    },
    {
    "_id": "5fa2ca6abe7a379ec4234899",
    "Name":"Kubernetes is the future"
    }
]
###### EXTRA / #######