# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-mobipocket/kdegraphics-mobipocket-4.9.0.ebuild,v 1.2 2012/08/11 18:40:07 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep okular)"
RDEPEND=${DEPEND}
