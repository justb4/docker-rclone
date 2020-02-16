FROM alpine:3.11.3

ARG TIMEZONE="Europe/Amsterdam"
ARG LOCALE="en_US.UTF-8"
ARG BUILD_DATE="auto"
ARG VERSION="1.51.0-3"
ARG RC_VERSION="1.51.0"

LABEL build_version="justb4 version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL credits="original dev Brian J. Cardiff <bcardiff@gmail.com>"
LABEL maintainer="Just van den Broecke <justb4@gmail.com>"

ENV RC_VERSION=${RC_VERSION} \
	ARCH="amd64"  \
	SYNC_SRC=""    \
	SYNC_DEST=""    \
	SYNC_OPTS="-v"  \
	RCLONE_OPTS="--config /config/rclone.conf" \
	CRON="" \
	CRON_ABORT="" \
	FORCE_SYNC=""  \
	CHECK_URL=""  \
	TZ=${TIMEZONE}

# https://downloads.rclone.org/v1.51.0/rclone-v1.51.0-linux-amd64.zip
RUN apk -U add ca-certificates fuse dcron wget tzdata \
	&& cd /tmp && wget -q https://downloads.rclone.org/v${RC_VERSION}/rclone-v${RC_VERSION}-linux-${ARCH}.zip  \
	&& unzip /tmp/rclone-v${RC_VERSION}-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
	&& rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
