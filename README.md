## WAT

If you need to test-drive your ldap authentication or need a test-server to test your ldap against, this docker-image could be of use. It does come with pre-deployed users and groups, so you can test authentication and filters right away.

## Database layout

Using the include `docker-compose.yml`, you will have 2 servers started as an example, with 2 slightly different layous, based on `data-template-type1.ldif` and `data-template-type2.ldif`

Server 1 has the port 1389 and the default domain example.org
- admin user: `dc=admin,dc=example,dc=org`
- admin password: `admin`

Server 2 has the port 2389 and the default domain example.org
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
- cn=user1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=user1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=userExcluded1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=user1,ou=base2,ou=accounts,<LDAP_BASE_DN>
passwords are always like the `cn`, so `included1` for the user `cn=included1,ou=accounts,<LDAP_BASE_DN>` and so on

## Groups

We have one group

- cn=drupalwiki,ou=base1,ou=groups,<LDAP_BASE_DN>

with the following members

- cn=included1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=included2,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=included3,ou=base1,ou=accounts,<LDAP_BASE_DN>
- 

### Type 2 Template

#### Users
- cn=included1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=included2,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=included3,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=excluded1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=excluded2,ou=base1,ou=accounts,<LDAP_BASE_DN>

passwords are always like the `cn`, so `included1` for the user `cn=included1,ou=accounts,<LDAP_BASE_DN>` and so on

#### Groups

We have one group

cn=drupalwiki,ou=base1,ou=groups,<LDAP_BASE_DN>

with the following members

- cn=included1,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=included2,ou=base1,ou=accounts,<LDAP_BASE_DN>
- cn=included3,ou=base1,ou=accounts,<LDAP_BASE_DN>

## build

You can build your images using your custom templates, custom password or LDAP_DOMAIN. See the `Dockerfile` included here
and just make it your own, if you like. Also see the templates and see how you can adopt or modify them to your liking.
