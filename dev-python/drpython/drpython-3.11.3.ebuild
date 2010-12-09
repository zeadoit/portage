# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/drpython/drpython-3.11.3.ebuild,v 1.1 2010/12/08 18:35:27 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_PN="DrPython"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="A powerful cross-platform IDE for Python"
HOMEPAGE="http://drpython.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/wxpython-2.6"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-165-wxversion.patch"

	sed \
		-e "/'drpython.pyw', 'drpython.lin'/d" \
		-e "/scripts=\['postinst.py'\],/d" \
		-i setup.py || die "sed failed"
	sed -e "s/arguments)c/arguments)/" -i examples/DrScript/SetTerminalArgs.py || die "sed failed"
}

src_install() {
	distutils_src_install
	
	install_drpython_wrapper() {
		make_wrapper drpython-${PYTHON_ABI} "$(PYTHON -a) $(python_get_sitedir)/${PN}/drpython.py"
	}
	python_execute_function -q install_drpython_wrapper
	python_generate_wrapper_scripts "${ED}usr/bin/drpython"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "DrPython plugins are available on DrPython homepage:"
	elog "http://sourceforge.net/projects/drpython/files/DrPython%20Plugins/"
}
