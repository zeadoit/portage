# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/evolution-python/evolution-python-2.32.0.ebuild,v 1.6 2011/03/21 21:33:15 xarthisius Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="evolution evolution_ecal"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

DESCRIPTION="Python bindings for Evolution and Evolution Data Server"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-extra/evolution-data-server-1.2
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
