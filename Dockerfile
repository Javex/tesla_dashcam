FROM python:3-alpine

WORKDIR /usr/src/app/tesla_dashcam

ENV LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib

ARG DEBIAN_FRONTEND=noninteractive

RUN addgroup -S -g 1000 tesla_dashcam && adduser -S -D -u 1000 -h /usr/src/app/tesla_dashcam -G tesla_dashcam -s /bin/sh tesla_dashcam

RUN apk add --no-cache --update \
    shadow \
    gcc \
    libc-dev \
    linux-headers \
    tzdata \
    ttf-freefont \
    libnotify \
    jpeg-dev \
    zlib-dev \
    openssl-dev \
    ffmpeg \
    # ffmpeg-libs \
 && mkdir /usr/share/fonts/truetype \
 && ln -s /usr/share/fonts/TTF /usr/share/fonts/truetype/freefont

COPY requirements.txt /usr/src/app/tesla_dashcam
RUN pip install -r requirements.txt
COPY tesla_dashcam /usr/src/app/tesla_dashcam/tesla_dashcam
COPY docker-entrypoint.sh /usr/src/app/tesla_dashcam/
RUN chown -R tesla_dashcam:tesla_dashcam /usr/src/app/tesla_dashcam

ENV PYTHONUNBUFFERED=true
ENV TZ=America/New_York

ENTRYPOINT [ "/bin/sh", "docker-entrypoint.sh" ]
