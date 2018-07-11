FROM alpine:3.6

RUN apk add --update nginx

RUN addgroup -g 786 appuser && \
    adduser -D -u 786 -G appuser appuser

RUN mkdir -p /run/nginx

RUN chown appuser /run/nginx

USER appuser

COPY nginx.conf /etc/nginx/

# copy swagger files to the `/js` folder
COPY ./index.html /usr/share/nginx/html/
ADD ./dist/*.js /usr/share/nginx/html/dist/
ADD ./dist/*.map /usr/share/nginx/html/dist/
ADD ./dist/*.css /usr/share/nginx/html/dist/
ADD ./dist/*.png /usr/share/nginx/html/dist/
ADD ./docker-run.sh /usr/share/nginx/

EXPOSE 8080

CMD ["sh", "/usr/share/nginx/docker-run.sh"]
