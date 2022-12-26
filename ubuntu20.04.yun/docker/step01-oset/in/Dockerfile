ARG dist=env-base
ARG tag=ubuntu20.04
FROM ${dist}:${tag}

MAINTAINER Sun Jiawei <sunjiawei@nj.ict.ac.cn>

WORKDIR /home
COPY depends /home/depends

RUN cd depends && \
    chmod 777  sset_os_oset_depends.sh && \
    /bin/bash sset_os_oset_depends.sh && \
    /bin/bash sset_os_oset_depends.sh && \
	rm -rf /home/depends && \
	rm -rf /home/sset_os_oset_depends.sh
