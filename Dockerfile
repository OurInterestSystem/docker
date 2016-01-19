FROM java:8-jdk

RUN apt-get update && apt-get install -y openssh-server git && rm -rf /var/lib/apt/lists/*

ENV ROOT_PWD 123456


RUN mkdir /var/run/sshd

RUN echo 'root:$ROOT_PWD' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'ClientAliveInterval 120' >> /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
