This repository contains [redis](redis.io) image with peristence support.
The RDB dir is `/redis/data`.

### Run

```sh
docker run -ti --rm \
  -v /dbdata/redis:/redis/data \
  planitar/redis
```

### Interesting approach

An interesting approach is used
[coreos-skydns-cloudformation](https://github.com/PlanitarInc/coreos-skydns-cloudformation).
There are 2 types of redis containers:
 1. [redis.volumes](https://github.com/PlanitarInc/coreos-skydns-cloudformation/blob/master/control/units/redis.volumes@.service)
    actually runs nothing, it is used to initialize the volume
    `/redis/data`:
      ```sh
      docker run \
        --name redis.volumes \
        --net none \
        --volume /redis/data \
        --entrypoint /usr/bin/printf \
        nordstrom/redis:${RELEASE} \
          "Redis data volumes container started"
       ```
     The container is started, it initiates the volume and then it just
     being kept stopped keeping the volume from being removed.

 2. [redis](https://github.com/PlanitarInc/coreos-skydns-cloudformation/blob/master/control/units/redis.volumes@.service)
    runs the Redis server itself:
      ```sh
      docker run \
        --name redis \
        --volumes-from redis.volumes \
        --publish 6379:6379 \
        nordstrom/redis:${RELEASE}
      ```
    The container can be started, removed, upgraded, then started again.
    The RDB data is stored in `/redis/data` volume.

This is an interesting scheme. However this won't survive a machine reboot.

The simplest solution to survive a reboot might be mapping `/redis/data` volume
to persistent filesystem.
