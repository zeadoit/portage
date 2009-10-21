# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystemlog/ksystemlog-4.3.2.ebuild,v 1.2 2009/10/17 09:07:03 abcd Exp $

EAPI="2"

KMNAME="kdeadmin"

inherit kde4-meta

DESCRIPTION="KDE system log viewer"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

# tests hang, last checked for 4.3.1
RESTRICT="test"