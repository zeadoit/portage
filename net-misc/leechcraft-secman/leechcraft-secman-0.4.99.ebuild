# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-secman/leechcraft-secman-0.4.99.ebuild,v 1.2 2012/02/04 19:17:25 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Security and personal data manager for LeechCraft"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
