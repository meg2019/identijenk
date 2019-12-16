FROM jenkins/jenkins:lts
USER root
RUN apt-get update \
       && apt-get update \
       && apt-get install -y apt-transport-https \
	   && apt-get install -y ca-certificates \
	   && apt-get install -y curl \
	   && apt-get install -y gnupg2 \
	   && apt-get install -y sudo \
	   && apt-get install -y software-properties-common \
	   && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
	   && apt-key fingerprint 0EBFCD88 \
	   && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
	   && apt-get update \
	   && apt-get install -y docker-ce \
	   && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
      && chmod +x /usr/local/bin/docker-compose