FROM ubuntu:16.04

WORKDIR /home

RUN apt-get update
RUN apt-get install -y cmake g++ ruby ruby-dev git ninja-build libboost-all-dev
RUN gem install bundler

ENV GMOCK_VER=1.7.0
ENV CMAKE_CXX_COMPILER=/usr/bin/g++

RUN git clone https://github.com/cucumber/cucumber-cpp.git

WORKDIR /home/cucumber-cpp

RUN bundle install
RUN git submodule init
RUN git submodule update
RUN cmake -E make_directory build
RUN cmake -E chdir build cmake --DCUKE_ENABLE_EXAMPLES=on ..
RUN cmake --build build
RUN cmake --build build --target test
RUN cmake --build build --target features
