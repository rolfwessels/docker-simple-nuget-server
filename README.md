# docker-simple-nuget-server
Docker file and auto building of simple-nuget-server (https://github.com/Daniel15/simple-nuget-server)


# To run on server

```
# install docker https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
curl https://get.docker.com | sh

# run
docker run --name docker-simple-nuget-server \
           -e 'NUGET_API_KEY=e46c582041db4cbe86a84b76a374383a' \
           -e 'NUGET_HOST=myhostname.com' \
           -p 80:80 \
           rolfwessels/docker-simple-nuget-server:latest 
```


# For developers

```
# install docker https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
curl https://get.docker.com | sh

# to build the image
sh docker_build.sh

# to run the image for debugging
sh docker_run.sh

#on windows machine 
test.cmd http://192.168.1.250:8083/ e46c582041db4cbe86a84b76a374383a


```



## Note:
I tried https://github.com/sunsided/docker-nuget but had issues with the base url. Unfortuately this repo is not being maintained and I was unable to get it up and running again.
