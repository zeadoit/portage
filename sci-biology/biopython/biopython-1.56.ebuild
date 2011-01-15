# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.56.ebuild,v 1.3 2011/01/14 19:12:38 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Biopython - Python modules for computational molecular biology"
HOMEPAGE="http://www.biopython.org http://pypi.python.org/pypi/biopython"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc ~x86"
IUSE="mysql postgres"

RDEPEND="dev-python/numpy
	>=dev-python/reportlab-2.0
	mysql? ( dev-python/mysql-python )
	postgres? ( dev-python/psycopg )"
DEPEND="${RDEPEND}
	sys-devel/flex"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="CONTRIB DEPRECATED NEWS README"
PYTHON_MODNAME="Bio BioSQL"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-1.51-flex.patch"
}

src_test() {
	testing() {
		cd Tests
		PYTHONPATH="$(ls -d ../build/lib.*)" "$(PYTHON)" run_tests.py
	}
	python_execute_function --nonfatal -s testing
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r Doc/* || die "Installation of documentation failed"
	insinto /usr/share/${PN}
	cp -r --preserve=mode Scripts Tests "${ED}usr/share/${PN}" || die "Installation of shared files failed"
}
