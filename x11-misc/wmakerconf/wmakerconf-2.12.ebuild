# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmakerconf/wmakerconf-2.12.ebuild,v 1.3 2010/08/24 11:54:07 fauli Exp $

EAPI=2

DESCRIPTION="X based config tool for the windowmaker X windowmanager."
HOMEPAGE="http://wmakerconf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="imlib nls perl"

RDEPEND="x11-libs/gtk+:2
	>=x11-wm/windowmaker-0.90.0
	imlib? ( media-libs/imlib )
	perl? ( dev-lang/perl
		dev-perl/HTML-Parser
		dev-perl/libwww-perl
		www-client/lynx
		net-misc/wget )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_configure() {
	local myconf
	use imlib || myconf="--disable-imlibtest"

	econf \
		$(use_enable perl upgrade) \
		$(use_enable nls) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" gnulocaledir="${D}/usr/share/locale" install || die
	dodoc AUTHORS ChangeLog MANUAL NEWS README TODO
	doman man/*.1

	rm -f "${D}"/usr/share/${PN}/{AUTHORS,README,COPYING,NEWS,MANUAL,ABOUT-NLS,NLS-TEAM1,ChangeLog}
}
