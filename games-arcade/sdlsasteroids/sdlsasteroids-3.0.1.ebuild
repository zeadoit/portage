# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlsasteroids/sdlsasteroids-3.0.1.ebuild,v 1.5 2010/09/22 06:49:33 tupone Exp $
EAPI="2"

inherit eutils games

DESCRIPTION="Rework of Sasteroids using SDL"
HOMEPAGE="http://sdlsas.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdlsas/SDLSasteroids-${PV}.tar.gz"

LICENSE="GPL-2 freedist"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/sdl-mixer
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf"

S=${WORKDIR}/SDLSasteroids-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-ldflags.patch
		#-e '34 d' \
	sed -i \
		-e 's/make /$(MAKE) /' \
		-e 's/--strip//' \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	emake \
		GAMEDIR="${GAMES_DATADIR}/${PN}" \
		OPTS="${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodir /usr/share/man/man6/
	emake \
		GAMEDIR="${D}/${GAMES_DATADIR}/${PN}" \
		BINDIR="${D}/${GAMES_BINDIR}" \
		MANDIR="${D}/usr/share/man/" \
		install || die "emake install failed"
	dodoc ChangeLog README README.xast TODO description
	prepgamesdirs
}
