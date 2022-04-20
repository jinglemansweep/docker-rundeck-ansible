ARG base_image="rundeck/rundeck"
ARG base_tag="4.0.1"

FROM ${base_image}:${base_tag}
MAINTAINER JingleManSweep <jinglemansweep@gmail.com>

ARG plugin_url="https://github.com/rundeck-plugins/ansible-plugin/releases/download/v3.2.0/ansible-plugin-3.2.0.jar"

ENV ANSIBLE_HOST_KEY_CHECKING=false
ENV RDECK_BASE=/home/rundeck
ENV MANPATH=${MANPATH}:${RDECK_BASE}/docs/man
ENV PATH=${PATH}:${RDECK_BASE}/tools/bin

RUN sudo apt-get -y update && \
    sudo apt-get -y --no-install-recommends install \
      ca-certificates python3-pip software-properties-common sshpass 

RUN sudo add-apt-repository --yes --update ppa:ansible/ansible && \
    sudo apt-get -y install ansible

ADD --chown=rundeck:root ${plugin_url} ${RDECK_BASE}/libext/

RUN sudo rm -rf /var/lib/apt/lists/*