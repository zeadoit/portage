# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdata/gdata-2.0.1.ebuild,v 1.3 2009/09/22 19:33:45 arfrever Exp $

EAPI="2"

inherit distutils eutils

MY_P="gdata-${PV}"

DESCRIPTION="Python client library for Google data APIs"
HOMEPAGE="http://code.google.com/p/gdata-python-client/"
SRC_URI="http://gdata-python-client.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

DEPEND=""
RDEPEND="|| ( >=dev-lang/python-2.5 dev-python/elementtree )"

PYTHON_MODNAME="atom gdata"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-2.0.2-fix_tests.patch"
}

src_test() {
	cd tests
	export PYTHONPATH=../src
	"${python}" run_data_tests.py -v || die "Data tests failed"

	# run_service_tests.py requires interaction (and a valid google account), so skip.
	#"${python}" run_service_tests.py -v || die "Service tests failed"
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r samples
	fi
}
