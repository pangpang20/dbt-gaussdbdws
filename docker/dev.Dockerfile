# this image does not get published, it is intended for local development only, see `Makefile` for usage
FROM ubuntu:24.04 AS base

# prevent python installation from asking for time zone region
ARG DEBIAN_FRONTEND=noninteractive

# Clean up APT cache and lists and disable post-invoke scripts
RUN echo 'APT::Update::Post-Invoke { }' > /etc/apt/apt.conf.d/99disable-post-invoke \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y software-properties-common

# Ensure proper permissions
RUN chmod -R 777 /var/cache/apt /var/cache/apt/archives /var/lib/apt/lists

# Install Python and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.10ubuntu1 \
        git-all=1:2.43.0-1ubuntu7.1 \
        libpq-dev=16.4-0ubuntu0.24.04.2 \
        python3.9=3.9.20-1+noble1 \
        python3.9-dev=3.9.20-1+noble1 \
        python3.9-distutils=3.9.20-1+noble1 \
        python3.9-venv=3.9.20-1+noble1 \
        python3-pip=24.0+dfsg-1ubuntu1 \
        python3-wheel=0.42.0-2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

# Update the default system interpreter to the newly installed version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# Install Python dependencies
RUN python -m pip install --upgrade "hatch==1.13.0" --no-cache-dir --compile

FROM base AS dbt-gaussdbdws-dev

HEALTHCHECK CMD python --version || exit 1

# send stdout/stderr to terminal
ENV PYTHONUNBUFFERED=1

# setup mount for local code
WORKDIR /opt/code
VOLUME /opt/code

# setup hatch virtual envs
RUN hatch config set dirs.env.virtual ".hatch"
