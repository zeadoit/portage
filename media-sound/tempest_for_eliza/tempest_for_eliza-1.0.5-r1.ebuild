# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tempest_for_eliza/tempest_for_eliza-1.0.5-r1.ebuild,v 1.3 2012/02/16 18:56:02 phajdan.jr Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="listen to music on the radio generated by images on your screen"
HOMEPAGE="http://www.erikyyy.de/tempest/"
SRC_URI="http://www.erikyyy.de/tempest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

src_configure() {
	tc-export CXX
	econf \
		--enable-debug \
		--enable-nowarnerror
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README

	rm songs/Makefile*
	insinto /usr/share/${PN}
	doins songs/* || die "doins failed"
}
