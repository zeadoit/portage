# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qarecord/qarecord-0.5.0.ebuild,v 1.1 2009/12/28 15:03:19 ssuominen Exp $

EAPI=2
inherit flag-o-matic multilib

DESCRIPTION="A simple harddisk recorder writing from an input audio stream to a .wav file"
HOMEPAGE="http://alsamodular.sourceforge.net/"
SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	append-ldflags -L/usr/$(get_libdir)/qt4
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
