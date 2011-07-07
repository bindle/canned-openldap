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
#   keys/Makefile - automates creating keys, csr, and self-signed certs
#

.PHONY: all clean info key request selfsign

all:
	@echo "Options:"
	@echo "   make key       -- creates private key"
	@echo "   make request   -- create certificate request"
	@echo "   make selfsign  -- create self signed cert"
	@echo " "
	@echo "   make info      -- show certificate information"
	@echo " "


key:       hostkey.pem
request:   hostcsr.pem
selfsign:  ca-certs.pem

info: hostcert.pem
	@openssl x509 -in hostcert.pem -inform pem -noout \
		-certopt no_pubkey,no_sigdump  -nameopt multiline \
		-text -fingerprint

hostkey.pem:
	test -f ${@} || openssl genrsa -out ${@} 4096
	chmod 600 ${@}
	touch ${@}

hostcsr.pem: hostkey.pem
	test -f ${@} || openssl req -new -key hostkey.pem -out ${@}
	touch ${@}

hostcert.pem: hostcsr.pem
	test -f ${@} || openssl x509 -req -days 365 -in hostcsr.pem \
		-signkey hostkey.pem -out ${@}
	touch ${@}

ca-certs.pem: hostcert.pem
	cp hostcert.pem ${@}
	touch ${@}

clean:
	@echo " "
	@echo "Please remove files manually."
	@echo " "

# end of Makefile
