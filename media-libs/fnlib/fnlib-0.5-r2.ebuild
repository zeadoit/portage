# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fnlib/fnlib-0.5-r2.ebuild,v 1.1 2010/12/31 17:54:13 jer Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Font Library for enlightenment"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-libs/imlib"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --sysconfdir=/etc/fnlib
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog HACKING NEWS README
	dodoc doc/fontinfo.README
}
