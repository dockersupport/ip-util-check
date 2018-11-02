Docker IP Utilization Check Script
==================================

This script scans the Docker overlay networks in a swarm and attempts to
determine whether the network has available capacity in its IP address
subnet ranges to upgrade to an 18.06 version of the docker engine from
an older version of the engine.  (However, as it turns out the 18.03
version of the engine has a one-time fix that will prevent issues
upgrading to 18.06 or later.)  The reason that such an upgrade may not
be seemless is that the 18.06 engine introduced a scalability
improvement to Docker load balancing that requires allocating an
additional IP address per node in the docker cluster that attaches to
the overlay network.

The script flags several potential conditions for each overlay:
  * IP address space is already completely exhausted
  * IP address space will be over capacity if upgrading to Docker engine
    18.06 or late
  * IP address space *could* become exhausted in the overlay if the
    cluster size scales up to a certain number of nodes
  * IP address space is allocated to > 80% capacity


Building the Container
======================
docker image build -t docker/ip-util-check .


Running the Container
=====================

    docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock \
            docker/ip-util-check
