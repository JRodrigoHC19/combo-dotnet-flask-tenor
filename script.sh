#!bin/bash

# Variables
ID_BACK="service-csharp"
ID_FRONT="service-flask"
BUILD_NAME_BACK="img-api"
BUILD_NAME_FRONT="img-web"

cd ./backend

docker build -t "$BUILD_NAME_BACK" .
docker run -it -d --rm -p 8080:8080 --name $ID_BACK $BUILD_NAME_BACK run

cd ../frontend

docker build -t "$BUILD_NAME_FRONT" .
docker run -it -d --rm -p 8000:5000 --name $ID_FRONT --link $ID_BACK:dotnet $BUILD_NAME_FRONT

sleep 20


docker stop $ID_BACK
docker stop $ID_FRONT

docker rmi $BUILD_NAME_BACK
docker rmi $BUILD_NAME_FRONT