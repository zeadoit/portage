# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-4.3.4.ebuild,v 1.2 2009/12/23 01:46:15 abcd Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +handbook python"

DEPEND="
	kde-base/qimageblitz
	python? ( $(add_kdebase_dep pykde4) )
"
RDEPEND="${DEPEND}
	python? ( $(add_kdebase_dep krosspython) )
"

PATCHES=( "${FILESDIR}/${PN}-as-needed.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with python PythonLibs)
	)

	kde4-meta_src_configure
}