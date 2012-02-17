# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.9-r2.ebuild,v 1.9 2012/02/16 22:50:00 vapier Exp $

EAPI=2
inherit eutils libtool

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi/"
SRC_URI="ftp://sourceware.org/pub/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="debug static-libs test"

RDEPEND=""
DEPEND="test? ( dev-util/dejagnu )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-interix.patch \
		"${FILESDIR}"/${P}-powerpc64-darwin.patch \
		"${FILESDIR}"/${P}-irix.patch \
		"${FILESDIR}"/${P}-arm-oabi.patch \
		"${FILESDIR}"/${P}-define-generic-symbols-carefully.patch \
		"${FILESDIR}"/${P}-strncmp.patch \
		"${FILESDIR}"/${P}-x32.patch

	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog* README
	find "${D}" -type f -name '*.la' -exec rm -f '{}' +
}
