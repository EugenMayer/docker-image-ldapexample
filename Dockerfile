FROM bitnami/openldap:2.6

ARG TEMPLATE_PATH=./data-template-type1-static.ldif
ARG CERTS_PATH=./tls/certs

ARG $LDAP_ROOT=example.org

ENV LDAP_ADMIN_PASSWORD="admin"
ENV LDAP_ROOT=$LDAP_ROOT

# TLS setup
ENV LDAP_ENABLE_TLS=yes
ENV LDAP_REQUIRE_TLS=no
ENV LDAP_TLS_VERIFY_CLIENT=never
ENV LDAP_TLS_CERT_FILE=/opt/bitnami/openldap/certs/openldap.crt
ENV LDAP_TLS_KEY_FILE=/opt/bitnami/openldap/certs/openldap.key
ENV LDAP_TLS_CA_FILE=/opt/bitnami/openldap/certs/openldapCA.crt
COPY $CERTS_PATH/cert.crt /opt/bitnami/openldap/certs/openldap.crt
COPY $CERTS_PATH/tls.key /opt/bitnami/openldap/certs/openldap.key
COPY $CERTS_PATH/ca.crt /opt/bitnami/openldap/certs/openldapCA.crt

RUN chown 1001:1001 /opt/bitnami/openldap/certs/openldap.crt /opt/bitnami/openldap/certs/openldap.key /opt/bitnami/openldap/certs/openldapCA.crt

# bootstrap setup
COPY $TEMPLATE_PATH /ldifs/50-bootstrap.ldif
COPY ./ldif/schema/bitnami/memberOf.ldif /schemas/memberOf.ldif
RUN chown -R 1001:1001 /ldifs/50-bootstrap.ldif /schemas/memberOf.ldif
