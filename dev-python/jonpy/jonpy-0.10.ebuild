# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jonpy/jonpy-0.10.ebuild,v 1.2 2012/06/01 13:02:47 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Powerful multi-threaded object-oriented CGI/FastCGI/mod_python/html-templating facilities"
HOMEPAGE="http://jonpy.sourceforge.net/ http://pypi.python.org/pypi/jonpy"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="jon"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}
