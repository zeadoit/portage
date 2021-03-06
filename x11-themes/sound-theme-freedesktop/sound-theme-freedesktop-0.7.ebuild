# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sound-theme-freedesktop/sound-theme-freedesktop-0.7.ebuild,v 1.12 2012/06/02 12:18:39 blueness Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Default freedesktop.org sound theme following the XDG theming specification"
HOMEPAGE="http://www.freedesktop.org/wiki/Specifications/sound-theme-spec"
SRC_URI="http://cgit.freedesktop.org/${PN}/snapshot/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2 CCPL-Attribution-3.0 CCPL-Attribution-ShareAlike-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="
	sys-devel/gettext
	dev-libs/glib:2
	>=dev-util/intltool-0.40"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CREDITS NEWS README || die
}
