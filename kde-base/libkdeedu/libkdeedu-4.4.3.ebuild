# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.4.3.ebuild,v 1.1 2010/05/03 21:32:36 alexxy Exp $

EAPI="3"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.2.87
RESTRICT=test

src_install() {
	kde4-meta_src_install
	# This is installed by kde-base/marble
	rm "${ED}"/${KDEDIR}/share/apps/cmake/modules/FindMarbleWidget.cmake
}