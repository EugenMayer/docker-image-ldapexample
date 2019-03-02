## WAT

If you need to test-drive your ldap authentication or need a test-server to test your ldap against, this docker-image could be of use. It does come with predeployed users and groups so you can test authentication and filters right away.

## Database layout

## start / connection

the exposed port is 389, so to start do

`docker run --name testldap -p 389:389 eugenmayer/ldapexample`

or just `docker-compose up` right in here

And then connect using `localhost:389` - not SSL/TLS with the user / password you see under admin below

## Admin
Admin user: cn=admin,dc=kontextwork-test,dc=de
Password: kontextwork

## Users
- cn=included1,ou=accounts,dc=kontextwork-test,dc=de
- cn=included2,ou=accounts,dc=kontextwork-test,dc=de
- cn=included3,ou=accounts,dc=kontextwork-test,dc=de
- cn=excluded1,ou=accounts,dc=kontextwork-test,dc=de
- cn=excluded2,ou=accounts,dc=kontextwork-test,dc=de

passwords are always like the `cn`, so `included1` for the user `cn=included1,ou=accounts,dc=kontextwork-test,dc=de` and so on

## Groups

We have one group

cn=drupalwiki,ou=groups,dc=kontextwork-test,dc=de

with the following members

- cn=included1,ou=accounts,dc=kontextwork-test,dc=de
- cn=included2,ou=accounts,dc=kontextwork-test,dc=de
- cn=included3,ou=accounts,dc=kontextwork-test,dc=de

## build

    make build
    