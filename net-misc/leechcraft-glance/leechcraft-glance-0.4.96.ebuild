# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-glance/leechcraft-glance-0.4.96.ebuild,v 1.1 2011/12/15 19:39:44 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="Glance, quick thumbnailed overview of opened tabs in LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
