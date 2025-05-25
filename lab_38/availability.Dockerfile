# Example Dockerfile for the web service (place in same directory)
# ---------------------------------------
# Dockerfile
FROM alpine

WORKDIR /scripts

COPY scripts/monitor.sh .

RUN apk --no-cache add curl bind-tools \
    && chmod +x /scripts/monitor.sh

CMD ["/scripts/monitor.sh"]

