# Spring Boot REST API experiment
Experimental project in Spring Boot to create a REST API. 

## Build and dockerize for k8s

To build and dockerize the project for k8s you can use the following commands:

```shell
docker build -t spring-boot-experiment .
```

## App run options

Pre-requisites:
- Java 
- Maven
- Docker
- Postgres 

### Locally

#### Database
For database is used postgres. The database is running in a docker container. You can run the container by going 
into the Experiment folder and running the following command:
```shell
docker compose up
```
Database runs on port 6543. The database is called `experiment` and the user is `admin` with password `admin`.

#### Running the application
To run the application you can use the following command:
```shell
mvn spring-boot:run
```
The application runs on port 8080.

### Docker

To run application in docker you can use the following command:

1. Build project with `mvn clean package`
2. Build and run docker image `docker compose --build`. This command runs the application and database in docker containers. To only run the app use `docker compose up spring-boot-experiment`.
    - if you want to run the application in the background you can use `docker compose up -d`
    - if you want to see the logs you can use `docker compose logs -f`
3. The application runs on port 8080.
4. Stop the application by running `docker compose down` or `CTRL+C`

## API
To access API via swagger go to http://localhost:8080/swagger-ui/index.html#.

## Deployment
To deploy the application to a server you can use the following steps:
1. Build the project with `mvn clean package`
2. Build the docker image with `docker build --no-cache -t spring-boot-experiment .`
3. In folder `Experiments` deploy the project with:
   ``` shell 
   kubectl apply -f spring-boot-experiment/spring-boot-experiment-secret.yml
   kubectl apply -f spring-boot-experiment/spring-boot-experiment-deployment.yml
   kubectl apply -f spring-boot-experiment/spring-boot-experiment-service.yml
   ```
4. To access the service you can use the following command: `minikube service spring-boot-experiment`
