FROM ubuntu:24.04

# Install a few dependencies
RUN apt-get -qq update && \
    apt-get -qq -y install \
        build-essential \
        cmake \
        git \
        libboost-all-dev \
        wget \
        libdeal.ii-dev \
        vim \
        tree \
        lintian \
        unzip \
        libyaml-cpp-dev
    
# This is some strange Docker feature. Normally, you don't need to add /usr/local to these
ENV LIBRARY_PATH $LIBRARY_PATH:/usr/local/lib/
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib/
ENV PATH $PATH:/usr/local/bin/

CMD mkdir /mnt/build && cd /mnt/build && \
    cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release ../cpack-exercise/ && \
    make package && \
    mv cpackexample*.tar.gz ../cpack-exercise/ && \
    mv cpackexample*.deb ../cpack-exercise/
