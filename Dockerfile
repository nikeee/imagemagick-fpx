FROM debian:latest

RUN apt-get update -qqqqy && \
    apt-get install -qqqqy \
    build-essential \
    cmake \
    git \
    libwebp-dev \
    libomp-dev \
    libltdl-dev \
    libjpeg-dev \
    libtiff-dev \
    libpng-dev

RUN git clone https://github.com/ImageMagick/libfpx /libfpx && \
    cd /libfpx && \
    ./configure && \
    make -j`nproc` && \
    make install && \
    rm -rf /libfpx

RUN git clone https://github.com/ImageMagick/ImageMagick /ImageMagick && \
    cd /ImageMagick && \
    ./configure --with-modules --with-fpx=yes --with-tiff=yes --with-png=yes --with-jpeg=yes && \
    make -j`nproc` && \
    make install && \
    rm -rf /ImageMagick

# https://stackoverflow.com/a/52280776
RUN ldconfig /usr/local/lib

COPY ./mass-convert.sh /usr/local/bin/mass-convert

ENTRYPOINT ["/usr/local/bin/magick"]