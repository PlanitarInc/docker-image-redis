FROM planitar/base

ADD conf /etc/redis/
ADD bin /opt/redis/bin
ENV PATH /opt/redis/bin:$PATH

EXPOSE 6379
EXPOSE 26379

CMD ["redis-server", "/etc/redis/redis.conf"]
