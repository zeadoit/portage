# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-simple-dtd/docbook-xml-simple-dtd-1.0-r2.ebuild,v 1.1 2011/03/29 02:33:51 flameeyes Exp $

inherit sgml-catalog

MY_PN="docbook-simple"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Simplified Docbook DTD for XML"
HOMEPAGE="http://www.oasis-open.org/docbook/"
SRC_URI="http://www.oasis-open.org/docbook/xml/simple/${PV}/${MY_P}.zip"

LICENSE="as-is"
SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=""
DEPEND=">=app-arch/unzip-5.41
	dev-libs/libxml2
	>=app-text/build-docbook-catalog-1.6"

S=${WORKDIR}

sgml-catalog_cat_include "/etc/sgml/xml-simple-docbook-${PV}.cat" \
	"/usr/share/sgml/docbook/${P#docbook-}/catalog"

src_install() {
	insinto /usr/share/sgml/docbook/${P#docbook-}
	doins *.dtd *.mod *.css

	newins "${FILESDIR}"/${P}.cat catalog
}

pkg_postinst() {
	build-docbook-catalog
	sgml-catalog_pkg_postinst
}

pkg_postrm() {
	build-docbook-catalog
	sgml-catalog_pkg_postrm
}
