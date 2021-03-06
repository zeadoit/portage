# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcuefile/libcuefile-477.ebuild,v 1.7 2012/06/07 22:17:35 ranger Exp $

EAPI=4
inherit cmake-utils

# svn export http://svn.musepack.net/libcuefile/trunk libcuefile-${PV}
# tar -cJf libcuefile-${PV}.tar.xz libcuefile-${PV}

DESCRIPTION="Cue File library from Musepack"
HOMEPAGE="http://www.musepack.net/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

src_install() {
	cmake-utils_src_install
	insinto /usr/include
	doins -r include/cuetools
}
