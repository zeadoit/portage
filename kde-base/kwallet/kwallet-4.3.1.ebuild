# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwallet/kwallet-4.3.1.ebuild,v 1.1 2009/09/01 16:09:07 tampakrap Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
"
RDEPEND="${DEPEND}
	>=kde-base/kcmshell-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kwalletd-${PV}:${SLOT}[kdeprefix=]
"