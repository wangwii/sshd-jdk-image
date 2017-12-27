FROM frolvlad/alpine-oraclejdk8:8.151.12-slim
LABEL maintainer "Wang Wei - https://github.com/wangwii"

# Install Packages
RUN apk --update add --no-cache openssh supervisor \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd

# Config supervisor
COPY supervisord.conf /

# Prepare sshd service
COPY etc /etc/
COPY start-sshd.sh /
COPY .ssh/ /root/.ssh/
RUN mkdir -p /var/log/sshd

EXPOSE 22
ENTRYPOINT ["/usr/bin/supervisord"]
