# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-menu-icons/kdebase-menu-icons-4.3.3.ebuild,v 1.5 2009/12/10 14:53:50 fauli Exp $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="menu"
inherit kde4-meta

DESCRIPTION="KDE menu icons"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

add_blocker kde-menu-icons