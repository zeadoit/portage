# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/byaccj/byaccj-1.15.ebuild,v 1.6 2011/12/04 16:49:51 hwoarang Exp $

EAPI="3"
DESCRIPTION="A java extension of BSD YACC-compatible parser generator"
HOMEPAGE="http://byaccj.sourceforge.net/"
MY_P="${PN}${PV}_src"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	cp "${FILESDIR}/Makefile" src/Makefile || die
	emake -C src linux || die "Failed too build"
}

src_install() {
	newbin src/yacc.linux "${PN}"  || die "Missing binary"
	dodoc docs/ACKNOWLEDGEMEN || die
}
