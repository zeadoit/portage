# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/smmap/smmap-0.8.1.ebuild,v 1.2 2011/08/27 20:53:54 neurogeek Exp $
# Ebuild generated by g-pypi 0.1

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="A pure git implementation of a sliding window memory map manager"
HOMEPAGE="http://pypi.python.org/pypi/smmap/0.8.1
	https://github.com/Byron/smmap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3*"
