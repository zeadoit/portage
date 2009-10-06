# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mini-xml/mini-xml-2.6.ebuild,v 1.1 2009/10/03 15:10:21 vostorga Exp $

inherit autotools multilib

MY_P="${P/mini-xml/mxml}"

DESCRIPTION="Small XML parsing library to read XML and XML-like data files."
HOMEPAGE="http://www.easysw.com/~mike/mxml"
SRC_URI="mirror://easysw/mxml/${PV}/${MY_P}.tar.gz"

LICENSE="Mini-XML"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="threads"

DEPEND="dev-util/pkgconfig"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_test() {
	emake testmxml
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:755 -s:755:" Makefile.in || die "sed failed"
	sed -i "/^TARGETS/s: testmxml::" Makefile.in || die "sed failed"
	rm configure
#	eautoreconf
	eautoconf
}

src_compile() {
	econf \
		--enable-shared \
		--libdir="/usr/$(get_libdir)" \
		--with-docdir="/usr/share/doc/${PF}/html" \
		$(use_enable threads)
	emake libmxml.a  libmxml.so.1.4 mxmldoc doc/mxml.man || die "make failed"
}

src_install() {
	emake DSTROOT="${D}" install || die "install failed"
	dodoc ANNOUNCEMENT CHANGES README
	rm "${D}/usr/share/doc/${PF}/html/"{CHANGES,COPYING,README}
}

src_test() {
	emake testmxml || die "make testmxml failed"
}