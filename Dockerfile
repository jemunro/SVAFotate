FROM mambaorg/micromamba:2.4-ubuntu25.10

USER root
WORKDIR /opt/svafotate

# Configure conda-forge only
RUN micromamba config prepend channels conda-forge && \
    micromamba config prepend channels bioconda && \
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
