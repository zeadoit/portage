# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-testing/zope-testing-3.8.7.ebuild,v 1.2 2010/02/10 18:35:28 armin76 Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope testing framework, including the testrunner script."
HOMEPAGE="http://pypi.python.org/pypi/zope.testing"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="examples"

RDEPEND="net-zope/zope-exceptions
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="CHANGES.txt documentation.txt README.txt"

src_install() {
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r src/zope/testing/testrunner/testrunner-ex{,-pp-lib,-pp-products} || die "Installation of examples failed"
	fi

	# Don't install examples in site-packages directories.
	rm -fr src/zope/testing/testrunner/testrunner-ex* build-*/lib/zope/testing/testrunner/testrunner-ex*

	distutils_src_install
}
