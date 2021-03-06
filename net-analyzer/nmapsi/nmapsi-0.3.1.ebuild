# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmapsi/nmapsi-0.3.1.ebuild,v 1.1 2012/05/07 21:13:54 kensington Exp $

EAPI=4
inherit base cmake-utils

MY_P=${PN}4-${PV/_/-}

DESCRIPTION="A Qt4 frontend to nmap"
HOMEPAGE="http://www.nmapsi4.org/"
SRC_URI="http://nmapsi4.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}
	net-analyzer/nmap"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS NEWS README TODO Translation )

PATCHES=(
	"${FILESDIR}/${P}-gcc-4.7.patch"
)
