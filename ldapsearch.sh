:

# $ env ... ~/git-servers/github.com/JochenHayek/ldapsearch/ldapsearch.sh
# $ env ... ~/git-servers/github.com/JochenHayek/ldapsearch/ldapsearch.sh >  ~/transfer/ldap.$( date '+%Y%m%d%H%M%S' ).txt

#       -W     Prompt for simple authentication.  This is used instead of specifying the password on the command line.
#
#       -w passwd
#              Use passwd as the password for simple authentication.
#
# -> ldapsearch: -W incompatible with -w

ldapsearch \
  \
  -x \
  -w "${ldap_password}" \
  \
  -D "${ldap_binddn}" \
  -b "${ldap_searchbase}" \
  -H "${ldapuri}" \
  \
  -E pr=500/noprompt \
  -z none \
  -o ldif-wrap=no \
  |

~/git-servers/github.com/JochenHayek/ldapsearch/ldapsearch--decode.pl
