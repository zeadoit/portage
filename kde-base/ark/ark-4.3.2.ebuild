# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ark/ark-4.3.2.ebuild,v 1.1 2009/10/06 17:57:32 alexxy Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE Archiving tool"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="+archive +bzip2 debug +handbook lzma zip"

DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
	archive? ( >=app-arch/libarchive-2.6.1[bzip2?,lzma?,zlib] )
	lzma? ( app-arch/xz-utils )
	zip? ( >=dev-libs/libzip-0.8 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with archive LibArchive)
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with lzma LibLZMA)
		$(cmake-utils_use_with zip LibZip)
	"
	kde4-meta_src_configure
}