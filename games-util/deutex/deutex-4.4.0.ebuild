# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/deutex/deutex-4.4.0.ebuild,v 1.1 2010/03/10 17:58:25 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="A wad composer for Doom, Heretic, Hexen and Strife"
HOMEPAGE="http://www.teaser.fr/~amajorel/deutex/"
SRC_URI="http://www.teaser.fr/~amajorel/deutex/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

PATCHES=( "${FILESDIR}"/${P}-makefile.patch )

src_install() {
	dobin deusf deutex || die
	doman deutex.6
	dodoc CHANGES README TODO
}