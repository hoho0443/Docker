FROM ubuntu:16.04
MAINTAINER hoho <hoho0443@gmail.com>

# Nginx install
ENV NGINX_VERSION 1.11.1
ENV NGX_PAGESPEED_VERSION 1.11.33.2

RUN apt-get update && \
        apt-get -qq -y install build-essential wget && \
    apt-get -qq -y install libssl-dev libpcre3-dev && \
    mkdir -p /tmp/src && cd /tmp/src && \
    wget -q -O - http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xfz - && \
    wget -q -O - https://github.com/pagespeed/ngx_pagespeed/archive/v${NGX_PAGESPEED_VERSION}-beta.tar.gz | tar xfz - && \
    cd /tmp/src/ngx_pagespeed-${NGX_PAGESPEED_VERSION}-beta && \
    wget -q -O - https://dl.google.com/dl/page-speed/psol/${NGX_PAGESPEED_VERSION}.tar.gz | tar xfz - && \
    cd /tmp/src/nginx-${NGINX_VERSION} && \
    ./configure \
        --prefix=/usr/local/nginx \
        --sbin-path=/usr/local/sbin \
        --with-http_realip_module \
        --with-http_ssl_module \
        --with-stream \
        --with-stream_ssl_module \
        --with-http_stub_status_module \
        --with-http_gzip_static_module \
        --with-http_v2_module \
        --add-dynamic-module=/tmp/src/ngx_pagespeed-${NGX_PAGESPEED_VERSION}-beta && \
    make --silent && \
    make install --silent && \
    apt-get -qq -y --purge remove build-essential wget && \
    apt-get -qq -y autoremove && \
    apt-get clean && \
    rm -rf /tmp/src

ADD docker-config/nginx.conf /usr/local/nginx/conf/nginx.conf
ADD docker-config/nginx_custom.conf /usr/local/nginx/conf/conf.d/nginx_custom.conf
ADD docker-config/proxy_params /usr/local/nginx/conf/proxy_params


# Node install 
RUN apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup_4.x| bash - && \
    apt-get -y install python build-essential nodejs

# Source copy
RUN mkdir -p /app
WORKDIR /app
ADD app/ /app

# run script
ADD docker-config/start.sh /app/start.sh
RUN chmod +x /app/start.sh
RUN npm install

# open port
EXPOSE 80
CMD /app/start.sh
