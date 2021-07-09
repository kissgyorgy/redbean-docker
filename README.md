# Redbean in Docker

The smallest possible web server in Docker!  
Built from Redbean: https://justine.lol/redbean/, a single-file distributable web server.

The final container takes only 304Kb:

```
$ docker images redbean-static
REPOSITORY       TAG       IMAGE ID       CREATED          SIZE
redbean-static   latest    769b5c0d2115   22 seconds ago   304kB
```

or just 155Kb if you use the tinylinux version of Redbean:

```
$ docker images redbean-tiny
REPOSITORY     TAG       IMAGE ID       CREATED          SIZE
redbean-tiny   latest    c70c5cd15c8b   10 seconds ago   155kB
```

# Examples

There are a couple of example Dockerfiles in this repo if you want to build it yourself:

- [Dockerfile-multistage](Dockerfile-multistage) of how to produce a container from "scratch"
- [Dockerfile-tinylinux](Dockerfile-tinylinux) for the world record small version
- [Dockerfile-onbuild](Dockerfile-onbuild) if you just want a scratch container

# Onbuild image

The [kissgyorgy/redbean-onbuild](https://hub.docker.com/r/kissgyorgy/redbean-onbuild)
image is not suitable to use by itself, you can build your own image with it:

1. Put your static files in the `assets` directory or set your own directory name with:

   ```
   docker build --build-arg ASSETS_DIR=something-else .
   ```

2. build a multi-stage Docker image with a `Dockerfile` like this:

   ```Dockerfile
   FROM kissgyorgy/redbean-onbuild as build

   FROM scratch

   COPY --from=build /redbean.com /
   CMD ["/redbean.com", "-vv", "-p", "80"]
   ```

Now your image includes redbean with all your static files in it and ready to run!
