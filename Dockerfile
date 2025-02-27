FROM openjdk:21-jdk-slim

WORKDIR /app
COPY . .

ENV SPRING_SERVER_PORT=8080
ENV KAFKA_BOOTSTRAP_URL=localhost:9092
ENV KAFKA_REQUEST_TOPIC_NAME=ticketRequest
ENV KAFKA_BOOKING_TOPIC_NAME=ticketBooking
ENV SPRING_PROFILES_ACTIVE=prod
ENV KAFKA_BATCH_SIZE=16384
ENV KAFKA_LINGER_MS=5
ENV KAFKA_COMPRESSION_TYPE=gzip
ENV KAFKA_BUFFER_MEMORY=33554432
ENV KAFKA_RETRIES=3
ENV KAFKA_RETRY_BACKOFF_MS=1000
ENV KAFKA_MAX_REQUEST_SIZE=1048576
ENV ALLOWED_ORIGIN=http://k8s-front-oliveyou-1e8b7ffabc-458159343.ap-northeast-2.elb.amazonaws.com

RUN chmod +x gradlew
RUN apt update && apt-get install findutils -y
RUN ./gradlew clean
RUN ./gradlew build

CMD ["java", "-jar", "build/libs/oliveyoung-be-0.0.1-SNAPSHOT.jar", "-spring.profiles.active=${SPRING_PROFILES_ACTIVE}"]
