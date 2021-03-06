# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconf/pkgconf-0.8.ebuild,v 1.13 2012/07/21 03:56:04 jdhore Exp $

EAPI="4"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/nenolod/pkgconf.git"
	inherit autotools git-2
else
	#inherit autotools vcs-snapshot
	inherit eutils
	#SRC_URI="https://github.com/nenolod/pkgconf/tarball/${P} -> ${P}.tar.gz"
	SRC_URI="http://nenolod.net/~nenolod/distfiles/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
fi

DESCRIPTION="pkg-config compatible replacement with no dependencies other than ANSI C89"
HOMEPAGE="https://github.com/nenolod/pkgconf"

LICENSE="BSD-1"
SLOT="0"
IUSE="+pkg-config"

DEPEND=""
RDEPEND="${DEPEND}
	pkg-config? (
		!dev-util/pkgconfig
		!dev-util/pkg-config-lite
		!dev-util/pkgconfig-openbsd[pkg-config]
	)"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-build-fbsd.patch
	[[ -e configure ]] || AT_M4DIR="m4" eautoreconf
}

src_compile() {
	emake V=1
}

src_install() {
	default
	use pkg-config \
		&& dosym pkgconf /usr/bin/pkg-config \
		|| rm "${ED}"/usr/share/aclocal/pkg.m4 \
		|| die
}
