# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-component/zope-component-3.9.3.ebuild,v 1.1 2010/03/23 18:16:57 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Component Architecture"
HOMEPAGE="http://pypi.python.org/pypi/zope.component"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/zodb
	net-zope/zope-configuration
	net-zope/zope-event
	net-zope/zope-hookable
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-proxy
	net-zope/zope-schema"
DEPEND="${RDEPEND}
	dev-python/setuptools"
# net-zope/zope-security depends on net-zope/zope-component, so net-zope/zope-security
# cannot be specified in DEPEND/RDEPEND due to circular dependencies.
PDEPEND="net-zope/zope-security"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="CHANGES.txt README.txt"