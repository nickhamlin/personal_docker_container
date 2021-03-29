FROM jupyter/minimal-notebook

COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip install -r requirements.txt

# For some reason, cartopy can't be pip installed
# NOTE: Temporarily disabled 
# RUN conda install -c conda-forge cartopy

COPY setup /opt/conda/share/jupyter/nbextensions/setup
RUN jupyter contrib nbextensions install --user
RUN jupyter nbextension enable setup/main
RUN jupyter nbextension enable code_prettify/code_prettify
RUN jupyter nbextension enable notify/notify


# set the timezone, if desired
# USER root
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get upgrade tzdata
# RUN echo "America/New_York" > /etc/timezone
# RUN dpkg-reconfigure -f noninteractive tzdata
# USER jovyan
