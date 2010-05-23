# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gsoap/gsoap-2.7.15.ebuild,v 1.1 2010/05/19 13:20:02 patrick Exp $

EAPI=2

inherit autotools eutils

MY_P="${PN}-2.7"

DESCRIPTION="A cross-platform open source C and C++ SDK to ease the development of SOAP/XML Web services"
HOMEPAGE="http://gsoap2.sourceforge.net"
SRC_URI="mirror://sourceforge/gsoap2/gsoap_${PV}.tar.gz"

LICENSE="GPL-2 gSOAP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug examples +ssl static-libs"

DEPEND="sys-devel/flex
	sys-devel/bison
	sys-libs/zlib
	ssl? ( dev-libs/openssl )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Fix Pre-ISO headers
	epatch \
		"${FILESDIR}/${PN}-2.7-fix-pre-iso-headers.patch" \
		"${FILESDIR}/${PN}-2.7-fedora-openssl.patch" \
		"${FILESDIR}/${PN}-2.7.10-fedora-install_soapcpp2_wsdl2h_aux.patch" \
		"${FILESDIR}/${P}-use_libtool.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable ssl openssl) \
		$(use_enable examples samples) \
		$(use_enable debug)
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	# yes, we also install the license-file since
	# it contains info about how to apply the licenses
	dodoc *.txt

	dohtml changelog.html

	use static-libs || rm -rf "${D}"/usr/lib*/*.la

	if use examples; then
		rm -rf gsoap/samples/Makefile* gsoap/samples/*/Makefile* gsoap/samples/*/*.o
		insinto /usr/share/doc/${PF}/examples
		doins -r gsoap/samples/*
	fi

	if use doc; then
		dohtml -r gsoap/doc/*
	fi
}