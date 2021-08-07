FROM quay.io/pypa/manylinux1_x86_64

USER root

COPY ./Vector_Root_CA_2.0.crt /
RUN cat /Vector_Root_CA_2.0.crt >> /etc/pki/tls/certs/ca-bundle.crt

COPY ./pip.conf /
ENV PIP_CONFIG_FILE /pip.conf

