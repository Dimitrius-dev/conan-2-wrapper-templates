# Conan-server-project template
___
## Description
___
Showcase of using conan-server 2.0 for library management.
___
Original server is contained to docker image for fast deploy.  
Page on ```docker hub```: https://hub.docker.com/repository/docker/dmitriiidev/conan-server/general
## Подготовка для развертывания
___
1. Create docker ```volume``` for library data.
Docker volume is a storage type which can store data without any active container.
Create docker volume named ```conan_db``` with command:
```
docker volume create conan_db
```

## Configure deploy parameters
___
There are two types to use docker image:
1. Use prepared image from ```docker hub```
2. Build image from sources in directory ```conan-server-build```

## Example the use prepared image from ```docker hub``` (directory ```conan-server```)
Create file ```docker-compose.yml``` in any place. 
Example config file ```docker-compose.yml```:
```
version: "3"
services:
  conan_server:
    image: dmitriiidev/conan-server:latest
    environment:
      - HOST_NAME=conancustom
      - PORT=9345
      - ROOT_USER_PASSWORD=root
    volumes:
      - conan_db:/data
    ports:
      - "9300:9345"

volumes:
  conan_db:
    external: true
```

С помощью блока ```environment``` можно задать настройки запуска контейнера с сервером.  
```HOST_NAME``` - имя для сервера conan.  
```PORT``` - порт для сервера conan.  
```ROOT_USER_PASSWORD``` - пароль от главного пользователя, который имеет логин ```root```.

In the block named ```image``` set image.  

In the block named ```ports``` set internal and external access container ports.
External port is os port. Internal is a container's app port.  
Port scheme ```"[external port]:[Internal port]"```, example: ```"9300:9345"```

## Build image from sources (directory ```conan-server-src```)
Directory ```conan-server-src``` stores file ```docker-compose.yml``` to deploy system of containers.
Set settings in ```docker-compose.yml``` file.

```
version: "3"
services:
  conan_server:
    build: ./conan-server-image
    environment:
      - HOST_NAME=conancustom
      - PORT=9345
      - ROOT_USER_PASSWORD=root
    volumes:
      - conan_db:/data
    ports:
      - "9300:9345"

volumes:
  conan_db:
    external: true
```

In the block named ```environment``` set deploy settings for container.  
```HOST_NAME``` - name of conan server.  
```PORT``` - access port (Internal port).  
```ROOT_USER_PASSWORD``` - password of user with login ```root```.

In the block named ```build``` set path to directory with ```Dockerfile```.  
In the block named ```image``` set image name.  

In the block named ```ports``` set port pair (external, internal).  
Port scheme ```"[external port]:[Internal port]"```, example: ```"9300:9345"```

## Build
___
To build and deploy move to directory with ```docker-compose.yml```
file and start container build by command:
```
docker-compose up
```
To build without deploy start this command:
```
docker-compose build
```