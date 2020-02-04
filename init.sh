echo 'update service config'

sed -i -- 's/apiKey.*/apiKey = "'"$NUGET_API_KEY"'";/g' $NUGET_PATH/inc/config.php 
sed -i -- 's/example.com/'"$NUGET_HOST"'/g' /etc/nginx/conf.d/default.conf 
sed -i -- 's/return.*http:.*;/return "'"$NUGET_DEFAULT_HTTP"':\/\/";/g' $NUGET_PATH/inc/core.php 
sed -i -- 's/.*upload_max_filesize.*=.*/upload_max_filesize = '$NUGET_UPLOAD_MAX_SIZE'/g' /etc/php/7.0/fpm/php.ini
sed -i -- 's/.*post_max_size.*=.*/post_max_size = '$NUGET_UPLOAD_MAX_SIZE'/g' /etc/php/7.0/fpm/php.ini
sed -i -- 's/.*client_max_body_size.*;/ client_max_body_size '$NUGET_UPLOAD_MAX_SIZE';/g' /etc/nginx/nginx.conf

chown www-data /app/db
chown www-data /app/packagefiles

echo 'Starting services'
/etc/init.d/php7.0-fpm start
/etc/init.d/php7.0-fpm restart
/etc/init.d/nginx restart

tail -f /dev/null
