FROM ubuntu:14.04
MAINTAINER Denis Karpenko <denis.karpenko@ihc.by>

RUN apt-get update && apt-get install -y \
    openssh-server \
    lsof \
    supervisor \
    build-essential \
    python-dev \
    git-core \
    libffi-dev \
    libpcre3-dev \
    gcc \
    autoconf \
    libtool \
    pkg-config \
    zlib1g-dev \
    libssl-dev \
    libexpat1-dev \
    libxslt1.1 \
    gnuplot \
    libpcre3 \
    libcairo2 \
    libpango1.0-0 \
    libgdk-pixbuf2.0-0 \
    libxml2-dev \
    libxslt-dev


ADD https://launchpad.net/plone/4.3/4.3.6/+download/Plone-4.3.6-UnifiedInstaller.tgz /opt/bika/

RUN tar -xvf /opt/bika/Plone-4.3.6-UnifiedInstaller.tgz -C /opt/bika/

RUN sudo /opt/bika/Plone-4.3.6-UnifiedInstaller/install.sh --target=/usr/local/Plone --password=adminpassword --build-python zeo

# Adding bika.lims entry to the eggs section.
RUN sed -ie '/^eggs =.*/{G;s/$/    bika.lims/;}'  /usr/local/Plone/zeocluster/buildout.cfg
RUN cd /usr/local/Plone/zeocluster && sudo -u plone_buildout bin/buildout

COPY ./bika_supervisord.conf /etc/supervisor/conf.d/bika.conf

RUN rm -rf /opt/bika

EXPOSE 8080

CMD ["/usr/bin/supervisord"]