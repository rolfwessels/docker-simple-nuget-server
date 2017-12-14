echo 'now run: sh init.sh'
docker run --rm  --name docker-simple-nuget-server -e 'NUGET_API_KEY=e46c582041db4cbe86a84b76a374383a' -e 'NUGET_HOST=121212121.com' -p 8083:80 -it rolfwessels/docker-simple-nuget-server:latest bash


