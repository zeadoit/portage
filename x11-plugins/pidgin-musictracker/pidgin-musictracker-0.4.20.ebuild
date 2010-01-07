# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-musictracker/pidgin-musictracker-0.4.20.ebuild,v 1.2 2010/01/05 03:36:43 josejx Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A Pidgin now playing plugin to publicise the songs you are listening to in your status message"
HOMEPAGE="http://code.google.com/p/pidgin-musictracker/"
SRC_URI="http://pidgin-musictracker.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND=">=net-im/pidgin-2.0.0
	>=dev-libs/dbus-glib-0.73
	dev-libs/libpcre
	>=sys-devel/gettext-0.17"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch ${FILESDIR}/${P}-fortify-abort.patch
}

src_configure() {
	econf \
		$(use_enable debug) \
		--disable-werror
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failure"
	dodoc AUTHORS ChangeLog INSTALL README THANKS || die "dodoc failed"
}