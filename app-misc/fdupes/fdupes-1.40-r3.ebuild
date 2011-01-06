# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.40-r3.ebuild,v 1.13 2011/01/05 18:42:52 jlec Exp $

inherit eutils toolchain-funcs

DESCRIPTION="identify/delete duplicate files residing within specified directories"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE="md5sum-external"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}-memcpy.patch \
		"${FILESDIR}"/${P}-external-md5sum-quotation.patch
	if use md5sum-external; then
		sed -i -e 's/^#EXTERNAL_MD5[[:blank:]]*= /EXTERNAL_MD5 = /g' \
					Makefile || die "sed failed"
	fi
	sed -e 's/-o fdupes/${CFLAGS} ${LDFLAGS} -o fdupes/' -i Makefile || die
	sed -i -e "s:gcc:$(tc-getCC):" Makefile || die
}

src_install() {
	dobin fdupes || die
	doman fdupes.1 || die
	dodoc CHANGES CONTRIBUTORS INSTALL README TODO || die
}
