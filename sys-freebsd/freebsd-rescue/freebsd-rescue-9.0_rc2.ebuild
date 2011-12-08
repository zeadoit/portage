# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-rescue/freebsd-rescue-9.0_rc2.ebuild,v 1.1 2011/12/07 17:08:47 aballier Exp $

EAPI=2

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's rescue binaries"
SLOT="0"
KEYWORDS="~x86-fbsd"
LICENSE="BSD zfs? ( CDDL )"

IUSE="atm netware nis zfs"

SRC_URI="mirror://gentoo/${UBIN}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${USBIN}.tar.bz2
		mirror://gentoo/${GNU}.tar.bz2
		mirror://gentoo/${SYS}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${RESCUE}.tar.bz2
		zfs? ( mirror://gentoo/${CDDL}.tar.bz2 )"

RDEPEND=""
DEPEND="sys-devel/flex
	>=app-arch/libarchive-2.7.1[static-libs]
	app-arch/xz-utils[static-libs]
	sys-libs/ncurses[static-libs]
	dev-libs/expat[static-libs]
	app-arch/bzip2[static-libs]
	dev-libs/libxml2:2[static-libs]
	dev-libs/openssl[static-libs]
	sys-libs/zlib[static-libs]
	dev-util/pkgconfig
	=sys-freebsd/freebsd-lib-${RV}*[atm?,netware?]
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/rescue"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} WITHOUT_ATM= "
	use netware || mymakeopts="${mymakeopts} WITHOUT_IPX= "
	use nis || mymakeopts="${mymakeopts} WITHOUT_NIS= "
	use zfs || mymakeopts="${mymakeopts} WITHOUT_CDDL= "
}

src_prepare() {
	# As they are patches from ${WORKDIR} apply them by hand
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}"-8.0-pkgconfig_static_libarchive.patch
	epatch "${FILESDIR}/${PN}"-7.1-zlib.patch
	epatch "${FILESDIR}/${PN}"-8.2-libzcleverlink.patch
	epatch "${FILESDIR}/freebsd-sbin-bsdxml2expat.patch"
}
