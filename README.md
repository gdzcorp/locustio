Use [locust.io](http://locust.io/) in docker, for great portability!
Base on https://github.com/christian-blades-cb/locustio-docker
## Usage

Assuming you have a `locustfile.py` in the root of your project, make a Dockerfile like this:

```dockerfile
FROM gdziwoki/locustio
```

Then build and run the docker image:

```shell
$ docker build -t mylocust .
$ docker run --rm -P mylocust
```

Any requirements you have listed in your `requirements.txt` will be installed during the build, and locust runs `locustfile.py` by default!

## Master/Slave

If you want to run in master/slave mode, specify a different file to run, etc, you can pass the appropriate vars to the container.

```shell
$ docker run -d -e TARGET_HOST=http://mysite  -e LOCUST_MODE=master --name master -P mylocust
$ docker run -d -e TARGET_HOST=http://mysite  -e LOCUST_MODE=slave -e LOCUST_MASTER=master --name slave -P mylocust
```
