From ubuntu:18.04

RUN apt-get -qq update && \
    apt-get install -y --no-install-recommends wget libx11-6 libfreetype6 libxrender1 libfontconfig1 libxext6 python-pip git curl && \
    mkdir -p /_tmp /nordic && \
    cd /_tmp && \
    wget --no-check-certificate -qO SES https://www.segger.com/downloads/embedded-studio/EmbeddedStudio_ARM_Linux_x64 && \
    tar xvf SES && \
    printf 'yes\n' | DISPLAY=:1 $(find arm_segger_* -name "install_segger*") --copy-files-to /ses && \
    pip install setuptools && \
    pip install nrfutil && \
    wget --no-check-certificate -qO cmd_tools https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/nRFCommandLineTools1030Linuxamd64tar.gz && \
    tar zxf cmd_tools && \
    tar zxf nRF-Command-Line-Tools*.tar.gz -C /nordic && \
    cd / && \
    rm -rf /_tmp
    
ENV PATH="/ses/bin:/nordic/mergehex:/nordic/nrfjprog:$PATH"
    
CMD ["emBuild && nrfutil --help && mergehex --help && nrfjprog --help"]
