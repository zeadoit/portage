# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-4.2.1-r1.ebuild,v 1.1 2009/03/15 14:30:13 scarabeus Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"
