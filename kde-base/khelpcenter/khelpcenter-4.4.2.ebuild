# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-4.4.2.ebuild,v 1.1 2010/03/30 21:04:42 spatz Exp $

EAPI="3"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

RDEPEND="
	>=www-misc/htdig-3.2.0_beta6-r1
"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/faq
			doc/glossary
			doc/quickstart
			doc/userguide
			doc/visualdict
		"
	fi

	kde4-meta_src_unpack
}