FROM ubuntu:25.04

RUN apt-get update
RUN apt-get install -y curl unzip sudo
RUN useradd -m -s /bin/bash quser

USER quser
WORKDIR /home/quser

RUN curl -fsSL https://cli.kiro.dev/install | bash
ENV PATH="/home/quser/.local/bin:$PATH"

CMD ["sleep", "infinity"]
