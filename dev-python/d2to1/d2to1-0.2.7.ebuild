# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/d2to1/d2to1-0.2.7.ebuild,v 1.2 2012/06/26 23:57:20 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Allows using distutils2-like setup.cfg files for a package metadata"
HOMEPAGE="http://pypi.python.org/pypi/d2to1"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"
