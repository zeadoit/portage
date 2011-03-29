# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/evilvte/evilvte-0.4.8.ebuild,v 1.1 2011/03/28 21:54:57 ssuominen Exp $

EAPI=4
inherit toolchain-funcs savedconfig

DESCRIPTION="VTE based, super lightweight terminal emulator"
HOMEPAGE="http://www.calno.com/evilvte"
SRC_URI="http://www.calno.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/vte:0
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	if use savedconfig; then
		restore_config src/config.h
	fi
}

src_configure() {
	tc-export CC
	./configure --prefix=/usr || die
}

src_compile() {
	emake -j1 || die
}

src_install() {
	default
	save_config src/config.h
}
