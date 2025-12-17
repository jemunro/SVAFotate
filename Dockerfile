FROM continuumio/miniconda3:25.3.1-1

RUN conda config --remove channels defaults && \
    conda config --add channels conda-forge && \
    conda config --set channel_priority strict && \
    conda install -n base -c conda-forge mamba -y && \
    conda clean -afy

WORKDIR /opt/svafotate

COPY . .

RUN mamba install -n base --file requirements.txt && \
    mamba clean -afy

RUN pip install --no-cache-dir .

RUN svafotate --help

ENTRYPOINT ["svafotate"]