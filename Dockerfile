FROM alpine:3.21
LABEL maintainer="Bence Madarasz <raptor@mbraptor.tech>"

RUN apk add --update --no-cache supervisor nginx tftp-hpa

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /supervisor/supervisord.conf

VOLUME /tftp
EXPOSE 69/udp

VOLUME /nginx
EXPOSE 80/tcp
COPY nginx-site.conf /etc/nginx/http.d/default.conf

CMD ["/usr/bin/supervisord", "-c", "/supervisor/supervisord.conf"]
