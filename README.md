[![build](https://github.com/EugenMayer/docker-image-ldapexample/actions/workflows/build_bitnami.yml/badge.svg)](https://github.com/EugenMayer/docker-image-ldapexample/actions/workflows/build_bitnami.yml) 

## WAT

If you need to test-drive your ldap authentication or need a test-server to test your ldap against, this docker-image could be of use. It does come with pre-deployed users and groups, so you can test authentication and filters right away.

## start

Just run 

```bash
./start.sh

#or 
sudo ./tls/generate-tls.sh ldap yes
docker-compose up -d
```

You can also run the prebuild images without any mounts

```bash
docker run -p 389:1389 ghcr.io/eugenmayer/ldaptestserver:bitnami-type1
#or 
docker run -p 389:1389 ghcr.io/eugenmayer/ldaptestserver:bitnami-type2
```

See the connection details under layout.

## Database layout

Using `docker-compose.yml`, you will have 2 servers started as an example, with 2 slightly different layouts, based on `data-template-type1.ldif` and `data-template-type2.ldif`

Server 1 has the port `10389` and the default domain example.org
- admin user: `cn=admin,dc=example,dc=org`
- admin password: `admin`

Server 2 has the port `20389` and the default domain example.org
- admin user: `cn=admin,dc=kontextwork-test,dc=de`
- admin password: `admin`

When you see the Users / Groups below, you need to replace the `<LDAP_BASE_DN>` with the domain, so either `dc=example,dc=org` or`dc=kontextwork-test,dc=de`

### Type 1 Template

BaseDN is `dc=example,dc=org`.

## Users
- uid=user1id,ou=accounts,ou=base1,,<LDAP_BASE_DN>
- uid=user2id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included1id,ou=accounts,ou=base2,<LDAP_BASE_DN>
- uid=readonlyid,ou=other accounts,ou=base1,<LDAP_BASE_DN>
- uid=userExcludedeid,ou=accounts,ou=base1,<LDAP_BASE_DN>

Passwords do match the the `uid`, so `user1` for the user `uid=user1,ou=accounts,<LDAP_BASE_DN>` and so on.

## Groups

We have two groups

- cn=myservice,ou=groups,ou=base1,<LDAP_BASE_DN>
- cn=specialservice,ou=groups,ou=base1,<LDAP_BASE_DN>

first one with the following members

- uid=user1id,ou=accounts,ou=base1,,<LDAP_BASE_DN>
- uid=user2id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included1id,ou=accounts,ou=base2,<LDAP_BASE_DN>

and second one with
- uid=user1id,ou=accounts,ou=base1,,<LDAP_BASE_DN>

### Type 2 Template

`<LDAP_BASE_DN>` is `dc=kontextwork-test,dc=de`.

#### Users

- uid=included1id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included2id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included3id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=readonlyid,ou=other accounts,ou=base1,<LDAP_BASE_DN>
- uid=includedMissingMailid,ou=accounts,ou=base1<LDAP_BASE_DN>
- uid=excluded1id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=excluded2id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included1id,ou=accounts,ou=base2,<LDAP_BASE_DN>

Passwords do match the the `uid`, so `included1` for the user `uid=included1,ou=accounts,<LDAP_BASE_DN>` and so on.

#### Groups

We have groups

- cn=myservice,ou=groupsou=base1,,<LDAP_BASE_DN>
- cn=otherservice,ou=groups,ou=base1,<LDAP_BASE_DN>
- cn=groupwithinvalid,ou=groups,ou=base1,<LDAP_BASE_DN>
- cn=differentservice,ou=groups,ou=base1,<LDAP_BASE_DN>
- cn=groupofgroups,ou=groups,ou=base1,<LDAP_BASE_DN>

with the following members

myservice
- uid=included1id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included2id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=included3id,ou=accounts,ou=base1,<LDAP_BASE_DN>
- uid=includedMissingMailid,ou=accounts,ou=base1<LDAP_BASE_DN>

otherservice
- uid=included1id,ou=accounts,ou=base1,<LDAP_BASE_DN>

differentservice
- uid=included2id,ou=accounts,ou=base1,<LDAP_BASE_DN>

groupofgroups
- cn=otherservice,ou=groups,ou=base1,<LDAP_BASE_DN>
- cn=differentservice,ou=groups,ou=base1,<LDAP_BASE_DN>

groupwithinvalid
- uid=includedMissingMailid,ou=accounts,ou=base1,<LDAP_BASE_DN>

## Build

You can build your images using your custom templates, custom password or LDAP_DOMAIN. See the `Dockerfile` included here
and just make it your own, if you like. Also see the templates and see how you can adopt or modify them to your liking.

**Important:** If you rely on `memberOf` you should ensure that your users are created before your groups in the ldif,
or memberOf will not work!

## Credits

Now-days credits to the once again great docker image of Bitnami [bitnami/openldap](https://hub.docker.com/r/bitnami/openldap) (and in the past, thanks to [osixia/docker-openldap](https://github.com/osixia/docker-openldap))
