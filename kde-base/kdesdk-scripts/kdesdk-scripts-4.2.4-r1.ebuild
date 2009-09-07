# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.2.4-r1.ebuild,v 1.1 2009/08/16 19:25:11 idl0r Exp $

EAPI="2"

KMNAME="kdesdk"
KMMODULE="scripts"
inherit kde4-meta

DESCRIPTION="Kdesdk Scripts - Some useful scripts for the development of applications"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

src_prepare() {
	# Disable hardcoded kdepimlibs check - only 4.2 branch is affected
	sed -i -e 's/find_package(KdepimLibs REQUIRED)/macro_optional_find_package(KdepimLibs)/' \
		CMakeLists.txt || die "failed to disable kdepimlibs hardcoded check"

	# bug 275069
	sed -i -e 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}