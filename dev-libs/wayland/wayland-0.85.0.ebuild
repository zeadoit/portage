# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wayland/wayland-0.85.0.ebuild,v 1.2 2012/02/12 18:26:40 jer Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}/${PN}"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit autotools toolchain-funcs $GIT_ECLASS

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="http://wayland.freedesktop.org/"

if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
else
	SRC_URI="http://wayland.freedesktop.org/releases/${P}.tar.xz"
fi

LICENSE="CCPL-Attribution-ShareAlike-3.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/expat
	dev-libs/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	if [[ ${PV} = 9999* ]]; then
		eautoreconf
	fi
}

src_configure() {
	if tc-is-cross-compiler ; then
		econf $(use_enable static-libs static) --disable-scanner
	else
		econf $(use_enable static-libs static)
	fi
}
