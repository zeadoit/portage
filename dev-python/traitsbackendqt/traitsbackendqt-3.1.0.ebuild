# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendqt/traitsbackendqt-3.1.0.ebuild,v 1.1 2009/03/27 10:48:34 bicatali Exp $

inherit distutils

MY_PN="TraitsBackendQt"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Qt4 backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/PyQt4"
DEPEND="dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
}
