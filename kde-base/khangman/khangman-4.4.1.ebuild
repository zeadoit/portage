# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khangman/khangman-4.4.1.ebuild,v 1.1 2010/03/02 17:45:34 tampakrap Exp $

EAPI="3"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="Classical hangman game for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kvtml-data)
"

KMEXTRACTONLY="
	libkdeedu/keduvocdocument
"