# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nikola/nikola-4.ebuild,v 1.1 2012/08/23 05:47:06 patrick Exp $

EAPI=4
PYTHON_COMPAT="python2_6 python2_7"

inherit python-distutils-ng

DESCRIPTION="A static website and blog generator"
HOMEPAGE="http://nikola.ralsina.com.ar/"
SRC_URI="http://nikola-generator.googlecode.com/files/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/docutils
	dev-python/doit
	dev-python/imaging
	>=dev-python/mako-0.6
	dev-python/pygments"

src_install() {
	python-distutils-ng_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm "${D}"/usr/*.txt

	dodoc README.md docs/*
}
