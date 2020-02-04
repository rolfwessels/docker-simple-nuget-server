FROM nginx:1.13

RUN apt-get update && \
    apt-get install --no-install-recommends -y  git  php7.0-fpm php7.0-sqlite php7.0-xml php7.0-zip apt-utils apt-transport-https ca-certificates

# for testings
RUN apt-get install --no-install-recommends -y  nano curl mc

ENV NUGET_PATH=/app
ENV NUGET_HOST=localhost
ENV NUGET_API_KEY=e46c582041db4cbe86a84b76a374383a
ENV NUGET_DEFAULT_HTTP=http
ENV NUGET_UPLOAD_MAX_SIZE=1024M

RUN git clone https://github.com/rolfwessels/simple-nuget-server.git $NUGET_PATH && \
    chown www-data:www-data $NUGET_PATH/db $NUGET_PATH/packagefiles && \
    chmod 0770 $NUGET_PATH/db $NUGET_PATH/packagefiles 

COPY nginx.conf.example /etc/nginx/conf.d/default.conf
RUN sed -i -- 's/\/var\/www\/simple-nuget-server/\/app/g' /etc/nginx/conf.d/default.conf  && \
    cat /etc/nginx/conf.d/default.conf 

RUN sed -i -- 's/.*#gzip  on;/    client_max_body_size '$NUGET_UPLOAD_MAX_SIZE';/g' /etc/nginx/nginx.conf && \
    cat /etc/nginx/nginx.conf 

# sed -i -- 's/fastcgi_pass php/fastcgi_pass unix:\/run\/php\/php7.0-fpm.sock/' /etc/nginx/conf.d/default.conf && \
RUN sed -i -- 's/.*upload_max_filesize.*=.*/upload_max_filesize = '$NUGET_UPLOAD_MAX_SIZE'/g' /etc/php/7.0/fpm/php.ini && sed -i -- 's/.*post_max_size.*=.*/post_max_size = '$NUGET_UPLOAD_MAX_SIZE'/g' /etc/php/7.0/fpm/php.ini && \
    sed -i -- 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini && \
    cat /etc/php/7.0/fpm/php.ini | grep upload_max_filesize

RUN sed -i -- 's/;listen.mode = .*/listen.mode = 0660/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    cat /etc/php/7.0/fpm/pool.d/www.conf | grep listen.

RUN usermod -G www-data nginx
RUN nginx -t

COPY init.sh /
EXPOSE 80
VOLUME ["/app/db","/app/packagefiles"]
CMD ["sh", "init.sh"]
