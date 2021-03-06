# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cpl/cpl-6.1.1.ebuild,v 1.3 2012/08/05 15:03:02 bicatali Exp $

EAPI=4

JAVA_PKG_OPT_USE=gasgano
AUTOTOOLS_AUTORECONF=1

inherit eutils java-pkg-opt-2 autotools-utils

DESCRIPTION="ESO common pipeline library for astronomical data reduction"
HOMEPAGE="http://www.eso.org/sci/software/cpl/"
SRC_URI="ftp://ftp.eso.org/pub/dfs/pipelines/libraries/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="doc gasgano static-libs threads"

RDEPEND=">=sci-libs/cfitsio-3.270
	>=sci-astronomy/wcslib-4.8.4
	>=sci-libs/fftw-3.1.2
	gasgano? ( sci-astronomy/gasgano )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-check-shared-libs.patch
	"${FILESDIR}"/${P}-use-system-ltdl.patch
)

src_prepare() {
	sed -e '/AM_C_PROTOTYPES/d' \
		-i configure.ac libcext/configure.ac || die #422455
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
		--disable-ltdl-install
		--without-included-ltdl
		$(use_enable threads)
	)
	if use gasgano; then
		myeconfargs+=(
			--enable-gasgano
			--with-gasgano="${EPREFIX}/usr"
			--with-gasgano-classpath="${EPREFIX}/usr/share/gasgano/lib"
			--with-java="$(java-config -O)"
		)
	else
		myeconfargs+=( --disable-gasgano )
	fi
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install all $(use doc && echo install-html)
}
