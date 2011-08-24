# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtxc_dxtn/libtxc_dxtn-1.0.1.ebuild,v 1.1 2011/08/23 17:48:10 mattst88 Exp $

EAPI=3

inherit autotools-utils multilib

DESCRIPTION="Helper library for	S3TC texture (de)compression"
HOMEPAGE="http://cgit.freedesktop.org/~mareko/libtxc_dxtn/"
SRC_URI="http://people.freedesktop.org/~cbrill/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="bindist fetch"

pkg_nofetch() {
	eerror "Due to unclear patent situation, you have to download the package"
	eerror "yourself. Grab it from:"
	eerror "	${SRC_URI}"
	eerror "and place in your distfiles directory:"
	eerror "	${DISTDIR}"
	eerror
	eerror "Please notice that depending on where you live, you might need"
	eerror "a valid license for s3tc in order to be legally allowed to use"
	eerror "the external library."
}

foreachabi() {
	local ABI

	for ABI in $(get_all_abis); do
		multilib_toolchain_setup ${ABI}
		AUTOTOOLS_BUILD_DIR=${WORKDIR}/${ABI} "${@}"
	done
}

src_configure() {
	foreachabi autotools-utils_src_configure
}

src_compile() {
	foreachabi autotools-utils_src_compile
}

src_install() {
	foreachabi autotools-utils_src_install
	remove_libtool_files all
}

pkg_postinst() {
	ewarn "Depending on where you live, you might need a valid license for s3tc"
	ewarn "in order to be legally allowed to use the external library."
	ewarn "Redistribution in binary form might also be problematic."
	ewarn
	ewarn "You have been warned. Have a nice day."
}
