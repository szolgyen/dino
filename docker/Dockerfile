# Base CUDA image
FROM nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04

# Avoid tzdata interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.9, pip, git, and build tools
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    wget \
    build-essential \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.9 python3.9-distutils python3.9-venv \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3.9 get-pip.py \
    && rm get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# Make python3.9 the default python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Create user and set working directory
RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user/

# Clone DINO repo
RUN git clone https://github.com/computationalpathologygroup/dino.git

RUN python3 -m pip install --no-cache-dir "numpy<1.24" tensorflow==2.10.0
RUN python3 -m pip install --no-cache-dir \
    --extra-index-url https://download.pytorch.org/whl/cu113 \
    -r dino/requirements.txt
RUN pip3 install wandb
RUN pip3 install scikit-learn

# Set PYTHONPATH so DINO is discoverable
ENV PYTHONPATH="${PYTHONPATH}:/home/user/dino"

# Default command
ENTRYPOINT ["/bin/bash"]