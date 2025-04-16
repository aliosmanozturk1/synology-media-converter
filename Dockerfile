FROM alpine:latest

RUN apk add --no-cache tzdata nodejs npm ffmpeg libva-intel-driver imagemagick libheif

COPY . /app
WORKDIR /app
RUN npm install --omit=dev
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
