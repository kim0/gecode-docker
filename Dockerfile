FROM kim0/minizinc
MAINTAINER Ahmed Kamal <email.ahmedkamal@googlemail.com>

# Make sure apt is up to date
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get -qq update && apt-get -qq install -y build-essential

WORKDIR /tmp
RUN wget -q 'http://www.gecode.org/download/gecode-5.0.0.tar.gz'
RUN tar xzf gecode-5.0.0.tar.gz
WORKDIR /tmp/gecode-5.0.0
RUN ./configure && make -j4 && make install
WORKDIR /tmp
RUN rm -rf gecode* && apt-get -qq purge build-essential && apt-get clean all
ENV LD_LIBRARY_PATH /usr/local/lib
