FROM osixia/openldap

ARG TEMPLATE_PATH=./data-template-type1.ldif
ARG LDAP_DOMAIN=example.org

ENV LDAP_DOMAIN=$LDAP_DOMAIN
ENV LDAP_TLS='true'
ENV LDAP_TLS_VERIFY_CLIENT='never'
ENV LDAP_ADMIN_PASSWORD="admin"
COPY $TEMPLATE_PATH /container/service/slapd/assets/config/bootstrap/ldif/50-bootstrap.ldif

RUN chown -R openldap:openldap /container/service/slapd/assets/config/bootstrap/ldif/50-bootstrap.ldif

CMD ["--copy-service"]
