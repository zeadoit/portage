# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.7_alpha2.ebuild,v 1.1 2010/01/01 01:52:40 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="${PN}-${PV/_alpha/a}"

DESCRIPTION="A CSS Cascading Style Sheets library for Python"
HOMEPAGE="http://code.google.com/p/cssutils http://pypi.python.org/pypi/cssutils"
SRC_URI="http://cssutils.googlecode.com/files/${MY_P}.zip http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/setuptools-0.6_rc7-r1"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/minimock dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	rm -fr "${D}"usr/lib*/python*/site-packages/tests
}