FROM cirrusci/flutter:stable

COPY . /app

RUN ["chmod", "+x", "/app/.docker/web_server.sh"]
WORKDIR /app

RUN flutter pub get
RUN flutter build web