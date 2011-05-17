# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/abuse/abuse-0.8.ebuild,v 1.1 2011/05/17 04:36:45 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="port of Abuse by Crack Dot Com"
HOMEPAGE="http://abuse.zoy.org/"
SRC_URI="http://abuse.zoy.org/raw-attachment/wiki/download/${P}.tar.gz"

LICENSE="GPL-2 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.6[audio,opengl,video]
	media-libs/sdl-mixer
	virtual/opengl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--with-assetdir="${GAMES_DATADIR}/${PN}"
}

src_install() {
	# Source-based install
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	doicon doc/${PN}.png
	make_desktop_entry abuse Abuse

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "NOTE: If you had previous version of abuse installed"
	elog "you may need to remove ~/.abuse for the game to work correctly."
}
