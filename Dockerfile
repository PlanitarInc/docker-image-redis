FROM planitar/base

ADD bin /opt/redis/bin
ADD conf/redis.conf /etc/redis/

ENV PATH /opt/redis/bin:$PATH

VOLUME /redis/data
EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]
