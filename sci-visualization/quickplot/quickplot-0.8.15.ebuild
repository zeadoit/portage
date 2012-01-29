# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/quickplot/quickplot-0.8.15.ebuild,v 1.3 2012/01/29 13:38:31 jlec Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A fast interactive 2D plotter"
HOMEPAGE="http://quickplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="sndfile"

RDEPEND="
	dev-cpp/gtkmm:2.4
	sndfile? ( media-libs/libsndfile )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-linking.patch
	# Some files have been moved around to more appropriate locations
	sed -i \
		-e 's|quickplot_icon.png|/usr/share/pixmaps/quickplot.png|' \
		-e  's|href="ChangeLog"|href="../ChangeLog.bz2"|' \
		index.html.in
	sed -i -e 's|href="COPYING"|href="/usr/portage/licenses/GPL-2"|' \
		about.html.in
	eautoreconf
}

src_configure() {
	econf $(use_with sndfile libsndfile)
}

src_compile() {
	emake htmldir=/usr/share/doc/${PF}/html || die "emake step failed."
}

src_install () {
	emake \
		DESTDIR="${D}" \
		htmldir=/usr/share/doc/${PF}/html \
		install || die "make install step failed."
	dodoc AUTHORS ChangeLog README README.devel TODO
	# Remove COPYING as it is specified in LICENCE. Move other stuff.
	cd "${D}"/usr/share/doc/${PF}/html
	rm COPYING quickplot_icon.png ChangeLog
	mv "${D}"/usr/share/pixmaps/quickplot_icon.png \
		"${D}"/usr/share/pixmaps/quickplot.png
	make_desktop_entry 'quickplot --no-pipe' Quickplot quickplot Graphics
	mv "${D}"/usr/share/applications/quickplot_\ --no-pipe.desktop \
		"${D}"/usr/share/applications/quickplot.desktop
}
