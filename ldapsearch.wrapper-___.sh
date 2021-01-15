:

# $ env ldap_password="${ldap_password}" ~/bin/ldapsearch.wrapper-___.sh > ~/transfer/ldap.$( date '+%Y%m%d%H%M%S' ).txt

env \
  \
  ldapuri='ldap://ldaps.___' \
  ldap_binddn='CN=___,OU=___,DC=___,DC=local' \
  ldap_searchbase='ou=___,ou=___,dc=___,dc=local' \
  \
  ~/git-servers/github.com/JochenHayek/ldapsearch/ldapsearch.sh \
  ;
