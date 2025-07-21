FROM python:3.10-slim-buster

# The dalai server runs on port 3000
EXPOSE 3000

# Install dependencies
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        g++ \
        git \
        make \
        python3-venv \
        software-properties-common


# Add NodeSource PPA to get Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# Install Node.js 18.x
RUN apt-get update \
    && apt-get install -y nodejs

WORKDIR /root/dalai

# Install dalai and its dependencies
RUN npm install dalai@0.3.1

RUN npx dalai alpaca setup


# Run the dalai server
CMD [ "npx", "dalai", "serve" ]

