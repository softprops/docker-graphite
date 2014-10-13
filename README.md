# docker graphite

A [Graphite](http://graphite.readthedocs.org/en/latest/overview.html) installation in a [Docker](https://www.docker.com/) container.

## usage

### build

```bash
$ docker build -t `whoami`/graphite .
```

### run

ports

port  | use
------|-----------------
80    | graphite web interface
2003  | carbon cache line interface
2004  | carban cache pickle interface
7002  | carbon cache query port

volumes

volume                    | use
--------------------------|-------------------------------
/var/lib/graphite/storage | where graphite stores its data

```bash
$ docker run \
   -ti --rm \
   -p 80:80 \
   -p 2003:2003 \
   -p 2004:2004 \
   -p 7002:7002 \
   `whoami`/graphite
```

### work it

```
$ open "http://$(boot2docker ip 2>/dev/null)"
```

Doug Tangren (softprops) 2013
