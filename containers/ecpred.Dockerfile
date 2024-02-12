FROM mambaorg/micromamba:1.5.3

LABEL image.author.name "Kristina K. Gagalova"
LABEL image.author.email "kristina.gagalova@curtin.edu.au"

# Copy the wrapper script into the container
COPY wrapper.sh /usr/local/bin/wrapper.sh

# include yalm file
COPY --chown=$MAMBA_USER:$MAMBA_USER env_yaml/ecpred_env.yaml /tmp/ecpred_env.yaml

RUN micromamba create -n ecpred

RUN micromamba install -y -n ecpred -f /tmp/ecpred_env.yaml && \
    micromamba clean --all --yes

ARG ECPRED_TAR
ARG LIBIDN_UBUNTU

USER 0

WORKDIR /tmp
RUN set -eu \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
      ca-certificates \
      gcc \
      build-essential \
      wget \
      gzip \
      zip \
  && update-ca-certificates \
  && wget -O libidn_ubuntu2_amd64.deb "${LIBIDN_UBUNTU}" \
  && apt install ./libidn_ubuntu2_amd64.deb \
  && rm ./libidn_ubuntu2_amd64.deb

RUN set -eu \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
	emboss-data \
	emboss-doc \
	embassy-domainatrix \ 
	embassy-domalign

RUN set -eu \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && update-ca-certificates \
  && mkdir -p ecpred \
  && cd ecpred \
  && wget -O ecpred.tar.gz "${ECPRED_TAR}" \
  && tar -zxf ecpred.tar.gz \
  && cd ECPred \
  && ./runLinux.sh \ 
  && rm lib/EMBOSS-6.5.7/emboss/pepstats \
  && ln -s /usr/bin/pepstats lib/EMBOSS-6.5.7/emboss/pepstats \
  && ln -s lib/ ECPredlib \
  && cd ../ \
  && mv ECPred /opt/ \
  && rm ecpred.tar.gz

ENV PATH="/opt/conda/envs/ecpred/bin:/opt/ECPred:${PATH}"
ENV PATH="/usr/local/bin/:${PATH}"
