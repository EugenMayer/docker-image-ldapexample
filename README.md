[![build](https://github.com/EugenMayer/docker-image-ldapexample/actions/workflows/build.yml/badge.svg)](https://github.com/EugenMayer/docker-image-ldapexample/actions/workflows/build.yml) 
[![build-and-push](https://github.com/EugenMayer/docker-image-ldapexample/actions/workflows/publish.yml/badge.svg)](https://github.com/EugenMayer/docker-image-ldapexample/actions/workflows/publish.yml)

## WAT

If you need to test-drive your ldap authentication or need a test-server to test your ldap against, this docker-image could be of use. It does come with pre-deployed users and groups, so you can test authentication and filters right away.

## Database layout

Using `docker-compose.yml`, you will have 2 servers started as an example, with 2 slightly different layous, based on `data-template-type1.ldif` and `data-template-type2.ldif`

Server 1 has the port `10389` and the default domain example.org
- admin user: `dc=admin,dc=example,dc=org`
- admin password: `admin`

Server 2 has the port `20389` and the default domain example.org
- admin user: `dc=admin,dc=kontextwork-test,dc=dc`
- admin password: `admin`

When you see the Users / Groups below, you need to replace the `<LDAP_BASE_DN>` with the domain, so either `dc=example,dc=org` or`dc=kontextwork-test,dc=de`

The ldif's are templated, so you can change the container env variable `LDAP_DOMAIN` to have your own domain, or change the password.

### start

Just run `docker-compose up -d` right in here.

You can also run the prebuild images without any mounts

```bash
docker run -p 389:389 ghcr.io/eugenmayer/ldaptestserver:type1
#or 
docker run -p 389:389 ghcr.io/eugenmayer/ldaptestserver:type2
```

See the connection details under layout.

### Type 1 Template

## Users
- uid=user1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=user1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=userExcluded1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=user1,ou=base2,ou=accounts,<LDAP_BASE_DN>

Passwords do match the the `uid`, so `user1` for the user `uid=user1,ou=accounts,<LDAP_BASE_DN>` and so on.

## Groups

We have one group

- uid=myservice,ou=base1,ou=groups,<LDAP_BASE_DN>

with the following members

- uid=included1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=included2,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=included3,ou=base1,ou=accounts,<LDAP_BASE_DN>

### Type 2 Template

#### Users

- uid=included1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=included2,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=included3,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=excluded1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=excluded2,ou=base1,ou=accounts,<LDAP_BASE_DN>

Passwords do match the the `uid`, so `included1` for the user `uid=included1,ou=accounts,<LDAP_BASE_DN>` and so on.

#### Groups

We have one group

- uid=drupalwiki,ou=base1,ou=groups,<LDAP_BASE_DN>

with the following members

- uid=included1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=included2,ou=base1,ou=accounts,<LDAP_BASE_DN>
- uid=included3,ou=base1,ou=accounts,<LDAP_BASE_DN>

## build

You can build your images using your custom templates, custom password or LDAP_DOMAIN. See the `Dockerfile` included here
and just make it your own, if you like. Also see the templates and see how you can adopt or modify them to your liking.

## credits

Well they all belong to [osixia/docker-openldap](https://github.com/osixia/docker-openldap) who did bring up this awesome
ldap docker image in the first place!
