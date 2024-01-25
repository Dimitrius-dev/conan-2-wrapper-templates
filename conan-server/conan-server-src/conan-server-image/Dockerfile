
# build image ----------------------

FROM python:3

WORKDIR /server

COPY server_setup.conf      /data/
COPY config_setter.py       /data/

ENV HOST_NAME default
ENV PORT port
ENV ROOT_USER_PASSWORD root


RUN ["pip", "install", "conan-server"]

#CMD echo example > /server/text1.txt

#RUN echo host_name=${HOST_NAME} > /server/text4.txt
#RUN echo port=$PORT > /server/text5.txt
#RUN echo host_name=$HOST_NAME > /server/text6.txt

# create container from image -----

CMD python /data/config_setter.py \
    /data/server_setup.conf /data/server.conf\
    port=$PORT host_name=$HOST_NAME && \
    conan_server -d /data

#CMD conan_server -d /data

