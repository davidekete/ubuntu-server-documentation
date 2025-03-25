# Use Ubuntu as the base image
FROM ubuntu:latest

# Set non-interactive mode to avoid prompts during package install
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /docs

# Update package list and install base dependencies
RUN apt update && apt install -y \
    make \
    sudo \
    git \
    curl \
    python3 \
    python3-venv \
    python3-pip \
    nodejs \
    npm \
 && apt clean && rm -rf /var/lib/apt/lists/*

 # Copy source files into container
COPY . /docs

# Create and activate a Python virtual environment
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --upgrade pip \
 && /opt/venv/bin/pip install -r .sphinx/requirements.txt


# Add virtual environment binaries to PATH
ENV PATH="/opt/venv/bin:$PATH"
