# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/conf-update/conf-update-1.0-r1.ebuild,v 1.6 2012/05/03 02:21:05 jdhore Exp $

inherit eutils toolchain-funcs

DESCRIPTION="${PN} is a ncurses-based config management utility"
HOMEPAGE="gopher://blubb.ch/11/software/conf-update"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="colordiff"

RDEPEND=">=dev-libs/glib-2.6
		dev-libs/openssl
		colordiff? ( app-misc/colordiff )"
DEPEND="virtual/pkgconfig
		${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-asneeded.patch \
			"${FILESDIR}"/${P}-regex-classes.patch
	sed -i -e "s/\$Rev:.*\\$/${PVR}/" conf-update.h || die 'version-sed failed'

	# -Wno-pointer-sign is gcc-4.1 only
	sed -i -e "s:-Wno-pointer-sign::g" \
		-e "s: -g::" Makefile || die 'gcc-sed failed'

	if use colordiff ; then
		sed -i -e "s/diff_tool=diff/diff_tool=colordiff/" ${PN}.conf || \
			die 'colordiff-sed failed'
	fi
}

src_compile() {
	emake CC=$(tc-getCC) || die 'emake failed'
}

src_install() {
	into /usr
	dosbin ${PN} || die 'dosbin failed'

	insinto /etc
	doins ${PN}.conf

	doman ${PN}.1
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.12.0"
	previous_less_than_0_12_0=$?
}

pkg_postinst() {
	if [[ $previous_less_than_0_12_0 = 0 ]] ; then
		ewarn "Note that the format for /etc/conf-update.conf changed in this"
		ewarn "version. You should merge the update of that file with e.g."
		ewarn "etc-update."
	fi
}
