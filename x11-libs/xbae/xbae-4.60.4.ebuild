# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xbae/xbae-4.60.4.ebuild,v 1.16 2012/05/25 14:24:27 jlec Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Motif-based widget to display a grid of cells as a spreadsheet"
HOMEPAGE="http://xbae.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="doc examples static-libs"

RDEPEND="
	x11-libs/openmotif:0
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-tmpl.patch
	"${FILESDIR}"/${P}-lxmp.patch
	"${FILESDIR}"/${P}-Makefile.in.patch
	)

src_configure() {
	local myeconfargs=( --enable-production )
	autotools-utils_src_configure
}

src_test() {
	cd examples
	emake
	./testall || die
	emake clean
}

src_install() {
	autotools-utils_src_install

	insinto /usr/share/aclocal
	doins ac_find_xbae.m4

	 use doc && dohtml -r doc/*

	if use examples; then
		find examples -name '*akefile*' -delete || die
		rm -f examples/{testall,extest} || die
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
