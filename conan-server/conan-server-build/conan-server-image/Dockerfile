
# build image ----------------------

FROM python:3

WORKDIR /server

COPY server.conf      /data/server.conf
COPY config_setter.py /data/config_setter.py

ENV HOST_NAME default
ENV PORT port


RUN ["pip", "install", "conan-server"]

#CMD echo example > /server/text1.txt

#RUN echo host_name=${HOST_NAME} > /server/text4.txt
#RUN echo port=$PORT > /server/text5.txt
#RUN echo host_name=$HOST_NAME > /server/text6.txt

# create container from image -----

CMD python /data/config_setter.py \
    /data/server.conf \
    port=$PORT host_name=$HOST_NAME && \
    conan_server -d /data

#CMD conan_server -d /data

