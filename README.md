# mesos-dns

![circleci][circleci]



Tiny Alpine image for running [mesos-dns](https://mesosphere.github.io/mesos-dns/)

### Running

Create [config.json](https://mesosphere.github.io/mesos-dns/docs/configuration-parameters.html) file for your environment
 
    docker run --rm --net host -it -v $PWD/config.json:/config.json quay.io/vektorcloud/mesos-dns

[circleci]: https://img.shields.io/circleci/build/gh/vektorcloud/mesos-dns?color=1dd6c9&logo=CircleCI&logoColor=1dd6c9&style=for-the-badge "mesos-dns"
