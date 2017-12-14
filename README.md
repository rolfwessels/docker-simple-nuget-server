# docker-simple-nuget-server

[![Build Status](https://travis-ci.org/rolfwessels/docker-simple-nuget-server.svg?branch=master)](https://travis-ci.org/rolfwessels/docker-simple-nuget-server)
[![Docker Pulls](https://img.shields.io/docker/pulls/rolfwessels/docker-simple-nuget-server.svg)](https://hub.docker.com/r/rolfwessels/docker-simple-nuget-server/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/rolfwessels/docker-simple-nuget-server/latest.svg)](https://hub.docker.com/r/rolfwessels/docker-simple-nuget-server/)

Docker file and auto building of simple-nuget-server (https://github.com/Daniel15/simple-nuget-server)


# To run on server

```
# install docker https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
curl https://get.docker.com | sh

# run
docker run --name docker-simple-nuget-server \
           -e 'NUGET_API_KEY=e46c582041db4cbe86a84b76a374383a' \
           -e 'NUGET_HOST=myhostname.com' \
           -p 8083:80 \
           rolfwessels/docker-simple-nuget-server:latest 
```

# using docker compose

If you run traefik you can add the following docker compose and it will allow you to add some basic auth to the service.

```
  nugetserver:
    container_name: "nugetserver"
    image: "rolfwessels/docker-simple-nuget-server"
    restart: unless-stopped
    environment:
      NUGET_API_KEY: "{{ nuget_api_key }}"
      NUGET_HOST: "nuget.{{ mon_url }}"
    volumes:
      - /data/nuget/database:/var/www/db
      - /data/nuget/packages:/var/www/packagefiles
    labels:
      - "traefik.enable=true"
      - "traefik.frontend.rule=Host:nuget.{{ mon_url }}" 
    # add this for some basic auth settings
      - "traefik.frontend.auth.basic={{ nuget_basic_auth }}"
```


# using the nuget as source

Run the following command in the folder where your sln file is.

`./.nuget/nuget sources Add -Name "myhostname" -Source https://nuget.myhostname.com  .\nuget.config`

If you have traefic with basic auth setup

`./.nuget/nuget sources Add -Name "myhostname" -Source https://nuget.myhostname.com -UserName user -Password xxxxxxx .\nuget.config`


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
