# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irman-python/irman-python-0.1.ebuild,v 1.17 2012/02/21 08:38:24 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="A minimal set of Python bindings for libirman."
HOMEPAGE="http://bluweb.com/chouser/proj/irman-python/"
SRC_URI="http://bluweb.com/chouser/proj/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 sparc x86"
IUSE=""

DEPEND="media-libs/libirman"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins test_name.py || die "doins failed"
}
