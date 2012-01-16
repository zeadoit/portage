# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/byacc/byacc-1.9-r3.ebuild,v 1.6 2012/01/15 17:35:10 armin76 Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="the best variant of the Yacc parser generator"
HOMEPAGE="http://dickey.his.com/byacc/byacc.html"
SRC_URI="http://sources.isc.org/devel/tools/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/mkstemp.patch

	# The following patch fixes yacc to run correctly on ia64 (and
	# other 64-bit arches).  See bug 46233
	epatch "${FILESDIR}"/byacc-1.9-ia64.patch

	# avoid stack access error, bug 232005
	epatch "${FILESDIR}"/${P}-CVE-2008-3196.patch
}

src_compile() {
	emake PROGRAM=byacc CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)" LINKER="$(tc-getCC)" || die
}

src_install() {
	dobin byacc || die
	newman yacc.1 byacc.1 || die
	dodoc ACKNOWLEDGEMENTS NEW_FEATURES NOTES README || die
}
