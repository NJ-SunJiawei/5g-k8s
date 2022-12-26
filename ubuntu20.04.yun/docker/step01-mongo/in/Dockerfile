ARG dist=env-base
ARG tag=ubuntu20.04
FROM ${dist}:${tag}

MAINTAINER Sun Jiawei <sunjiawei@nj.ict.ac.cn>

WORKDIR /mnt/mongo
COPY mongo_init.sh .

CMD /bin/bash  mongo_init.sh
