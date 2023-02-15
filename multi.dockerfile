FROM nvcr.io/nvidia/cuda:12.0.1-devel-ubuntu22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

# https://askubuntu.com/questions/804997/dpkg-error-processing-package-libc-bin-configure
# RUN rm /var/cache/ldconfig/aux-cache
# RUN /sbin/ldconfig

RUN apt-get update
#RUN apt-get upgrade --yes

RUN apt-get install -y --no-install-recommends \
    bash \
    python3 \
    python3-pip \
    python3-dev \
    curl \
    gcc \
    git \
    wget

RUN apt-get install -y ca-certificates && update-ca-certificates
RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN pip3 install --upgrade pip
RUN python3 -m pip install --no-cache-dir --pre torch torchvision torchaudio

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "python3 -c \"import torch; print('GPU Device name: ' + torch.cuda.get_device_name(0))\"" > start.sh
RUN chmod +x start.sh
CMD ["bash", "start.sh"]
