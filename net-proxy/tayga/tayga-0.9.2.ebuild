# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/tayga/tayga-0.9.2.ebuild,v 1.1 2011/06/16 22:28:24 xmw Exp $

EAPI=3

inherit autotools

DESCRIPTION="out-of-kernel stateless NAT64 implementation based on TUN"
HOMEPAGE="http://www.litech.org/tayga/"
SRC_URI="http://www.litech.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '/^CFLAGS/d' \
		-i configure.ac
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README || die
}
