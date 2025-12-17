FROM ghcr.io/mamba-org/micromamba:git-35c00b7-ubuntu22.04

USER root
WORKDIR /opt/svafotate

# set conda channels
RUN micromamba config prepend channels bioconda && \
    micromamba config prepend channels conda-forge && \
    micromamba config set channel_priority strict

# Copy repo
COPY . .

# Install deps exactly as upstream specifies
RUN micromamba install -y -n base --file requirements.txt && \
    micromamba clean --all --yes

# Install SVAFotate
RUN micromamba run -n base pip install --no-cache-dir .

ENV PATH=/opt/conda/bin:$PATH

RUN svafotate --version
