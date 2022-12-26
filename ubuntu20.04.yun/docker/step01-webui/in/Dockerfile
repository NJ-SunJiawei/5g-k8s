ARG dist=env-base
ARG tag=ubuntu20.04
FROM ${dist}:${tag}

MAINTAINER Sun Jiawei <sunjiawei@nj.ict.ac.cn>

WORKDIR /home
ADD webui.tar.gz .
COPY webui_init.sh .
EXPOSE 3000

CMD /bin/bash webui_init.sh
