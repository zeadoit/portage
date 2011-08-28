# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-pem/convert-pem-0.80.0.ebuild,v 1.1 2011/08/27 20:24:34 tove Exp $

EAPI=4

MY_PN=Convert-PEM
MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Read/write encrypted ASN.1 PEM files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="
	dev-perl/Class-ErrorHandler
	dev-perl/Convert-ASN1
	dev-perl/crypt-des-ede3
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
"
DEPEND="${RDEPEND}"

SRC_TEST=do
