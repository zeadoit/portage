# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libzpaq/libzpaq-3.00.ebuild,v 1.3 2012/05/24 04:33:22 vapier Exp $

EAPI=3

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils eutils

MY_P=${PN}${PV/./}
DESCRIPTION="Library to compress files or objects in the ZPAQ format"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/${MY_P}.zip"

LICENSE="zpaq"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_prepare() {
	EPATCH_OPTS+=-p1 epatch "${FILESDIR}"/0001-Add-autotools-files.patch
	# XXX: update the patch instead when the old version is gone
	touch libzpaqo.cpp || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-library-version=1:0:0
	)

	autotools-utils_src_configure
}
