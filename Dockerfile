FROM ghcr.io/mamba-org/micromamba:git-35c00b7-ubuntu22.04

USER root
WORKDIR /opt/svafotate

RUN micromamba config remove channels && \
    micromamba config prepend channels bioconda && \
    micromamba config prepend channels conda-forge && \
    micromamba config set channel_priority strict

# Copy repo
COPY . .

# Install deps exactly as upstream specifies
RUN micromamba install -y -n base --file requirements.txt && \
    micromamba clean --all --yes

# Install SVAFotate
RUN pip install --no-cache-dir .

RUN svafotate --help

ENTRYPOINT ["svafotate"]
