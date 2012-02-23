# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/obby/obby-0.4.8.ebuild,v 1.4 2012/02/23 17:23:13 ranger Exp $

EAPI=4

inherit multilib

DESCRIPTION="Library for collaborative text editing"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE="avahi ipv6 nls static-libs"

RDEPEND="net-libs/net6
		dev-libs/libsigc++:2
		avahi? ( net-dns/avahi )"
DEPEND="${RDEPEND}
		nls? ( sys-devel/gettext )"
DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	econf \
		$(use_with avahi zeroconf) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || rm -f "${D}"/usr/$(get_libdir)/lib${PN}.la
}
