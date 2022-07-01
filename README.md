# Redbean in Docker

The smallest possible web server in Docker!  
Built from Redbean: https://redbean.dev/, a single-file distributable web server.

The final container takes only 501 kB:

```
$ docker images redbean-static
REPOSITORY      TAG         IMAGE ID      CREATED         SIZE
redbean-static  latest      814da89a2fa7  16 minutes ago  501 kB
```

or just 186 kB if you use the tinylinux version of Redbean:

```
$ docker images redbean-tinylinux
REPOSITORY         TAG         IMAGE ID      CREATED        SIZE
redbean-tinylinux  latest      0b98596e96d8  2 seconds ago  186 kB
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
