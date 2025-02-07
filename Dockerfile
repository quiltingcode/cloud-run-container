# python version

FROM python:3.12-slim

#COPY local_dir container_dir
# what code
# COPY SRC folder and requirements.txt file into the container

COPY . /app
WORKDIR /app/

#default installs
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-dev \
    python3-setuptools \
    gcc \
    make

# create a virt env
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install pip --upgrade && \
    /opt/venv/bin/python -m pip install -r /app/src/requirements.txt

# purge unused
RUN apt-get remove -y --purge make gcc build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# make entrypoint executable
RUN chmod +x ./src/entrypoint.sh

# run app

CMD ["./src/entrypoint.sh"]