# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ansifilter/ansifilter-1.7.ebuild,v 1.1 2012/01/06 05:44:32 radhermit Exp $

EAPI=4

inherit toolchain-funcs qt4-r2

DESCRIPTION="Handles text files containing ANSI terminal escape codes"
HOMEPAGE="http://www.andre-simon.de/"
SRC_URI="http://www.andre-simon.de/zip/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

RDEPEND="
	qt4? (
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
	)"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	myopts=(
		"CC=$(tc-getCXX)"
		"CFLAGS=${CFLAGS} -c"
		"LDFLAGS=${LDFLAGS}"
		"DESTDIR=${ED}"
		"PREFIX=${EPREFIX}/usr"
		"doc_dir=${EPREFIX}/usr/share/doc/${PF}/"
	)
}

src_compile() {
	emake -f makefile "${myopts[@]}"
	if use qt4 ; then
		cd src/qt-gui
		eqmake4
		emake
	fi
}

src_install() {
	emake -f makefile "${myopts[@]}" install
	use qt4 && emake -f makefile "${myopts[@]}" install-gui
}
