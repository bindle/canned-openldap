#!/bin/sh
#
#   LDAP Configuration for ISP In A Can
#   Copyright (C) 2011 Bindle Binaries <syzdek@bindlebinaries.com>.
#
#   @BINDLE_BINARIES_BSD_LICENSE_START@
#
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions are
#   met:
#
#      * Redistributions of source code must retain the above copyright
#        notice, this list of conditions and the following disclaimer.
#      * Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.
#      * Neither the name of Bindle Binaries nor the
#        names of its contributors may be used to endorse or promote products
#        derived from this software without specific prior written permission.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BINDLE BINARIES BE LIABLE FOR
#   ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#   LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
#   OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
#   SUCH DAMAGE.
#
#   @BINDLE_BINARIES_BSD_LICENSE_END@
#
#   ldifs/suffixDN-test.sh - generates test data for o=test
#

if test "x${1}" == "x";then
   echo "Usage: ${0} infile > outfile";
   exit 1;
fi;

cat << EOF
#
#   LDIF  Structure:
#
#   +--o=test
#      \--o=presidents
#         +--ou=Groups
#         \--ou=People
EOF

COUNT=2;
LINE=`head -n ${COUNT} ${1} |tail -1`
while test "x${LINE}" != "x";do
   CN=`echo "${LINE}" |cut -d, -f2,3 |sed -e 's/,/ /g'`
   echo "#            +--cn=${CN}"
   COUNT=$((${COUNT}+1))
   LINE=`head -n ${COUNT} ${1} |tail -1`
done
echo "#"

cat << EOF

dn: o=presidents,o=test
description: Directory of Presidents
o: presidency
objectClass: top
objectClass: organization

dn: ou=People,o=presidents,o=test
ou: People
objectClass: top
objectClass: organizationalUnit

dn: ou=Groups,o=presidents,o=test
ou: Groups
objectClass: top
objectClass: organizationalUnit

EOF

COUNT=2;
LINE=`head -n ${COUNT} ${1} |tail -1`
while test "x${LINE}" != "x";do
   TERM=`echo ${LINE}     |cut -d, -f1`
   GN=`echo ${LINE}       |cut -d, -f2`
   SN=`echo ${LINE}       |cut -d, -f3`
   CN="${GN} ${SN}"
   START=`echo ${LINE}    |cut -d, -f4`
   STOP=`echo ${LINE}     |cut -d, -f5`
   PARTY=`echo ${LINE}    |cut -d, -f6`
   STATE=`echo ${LINE}    |cut -d, -f7`
cat << EOF
dn: cn=${CN},ou=People,o=presidents,o=test
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
uid: ${TERM}
givenName: ${GN}
surname: ${SN}
commonName: ${CN}
st: ${STATE}
description: ${PARTY}, President ${START} to ${STOP}
userPassword: {CRYPT}*

EOF
   COUNT=$((${COUNT}+1))
   LINE=`head -n ${COUNT} ${1} |tail -1`
done

exit 0;
