# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dragonplayer/dragonplayer-4.3.1.ebuild,v 1.1 2009/09/01 14:45:12 tampakrap Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://dragonplayer.net/"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
LICENSE="GPL-2"
IUSE="debug +handbook"

RDEPEND="
	>=media-libs/xine-lib-1.1.9[xcb]
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"