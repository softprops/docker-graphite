FROM debian:wheezy

MAINTAINER Doug Tangren <d.tangren@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade

RUN apt-get -y --force-yes \
            install supervisor \
            python-ldap python-cairo python-django \
            python-twisted python-django-tagging \
            python-simplejson python-memcache \
            python-pysqlite2 python-support python-pip \
            gunicorn nginx-light --no-install-recommends

RUN pip install whisper

RUN pip install \
        --install-option="--prefix=/var/lib/graphite" \
        --install-option="--install-lib=/var/lib/graphite/lib" \
        carbon

RUN pip install \
        --install-option="--prefix=/var/lib/graphite" \
        --install-option="--install-lib=/var/lib/graphite/webapp" \
        graphite-web

RUN mkdir -p /var/log/supervisor

COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./bin/run /bin/run

ADD ./etc/nginx.conf /etc/nginx/nginx.conf

ADD ./etc/initial_data.json /var/lib/graphite/webapp/graphite/initial_data.json

ADD ./etc/local_settings.py /var/lib/graphite/webapp/graphite/local_settings.py

ADD ./etc/storage-schemas.conf /var/lib/graphite/conf/storage-schemas.conf

EXPOSE 80 2003 2004 2013 2014 7002

VOLUME /var/lib/graphite/storage

CMD /bin/run

RUN apt-get autoremove -y && apt-get clean &&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*