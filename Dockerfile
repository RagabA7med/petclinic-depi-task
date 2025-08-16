# Stage 1: Build Petclinic
FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /src
ADD https://github.com/spring-projects/spring-petclinic/archive/refs/heads/main.tar.gz app.tar.gz
RUN tar -xzf app.tar.gz && mv spring-petclinic-main app
WORKDIR /src/app
RUN mvn -q -DskipTests package

# Stage 2: Runtime (Distroless)
FROM gcr.io/distroless/java21-debian12
WORKDIR /app
COPY --from=build /src/app/target/spring-petclinic-*.jar /app/app.jar

EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=mysql \
    SPRING_SQL_INIT_MODE=always \
    SPRING_SQL_INIT_PLATFORM=mysql \
    SPRING_DATASOURCE_HIKARI_MAXIMUM_POOL_SIZE=5

ENTRYPOINT ["java","-jar","/app/app.jar"]
