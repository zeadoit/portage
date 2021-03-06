# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/flexget/flexget-1.0_beta2881.ebuild,v 1.1 2012/05/20 01:55:33 floppym Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 *-pypy-* 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

if [[ ${PV} != 9999 ]]; then
	MY_P="FlexGet-${PV/_beta/r}"
	SRC_URI="http://download.flexget.com/unstable/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit subversion
	SRC_URI=""
	ESVN_REPO_URI="http://svn.flexget.com/trunk"
	KEYWORDS=""
fi

DESCRIPTION="Multipurpose automation tool for content like torrents, nzbs, podcasts, comics"
HOMEPAGE="http://flexget.com/"

LICENSE="MIT"
SLOT="0"
IUSE="deluge test transmission"

RDEPEND="
	>=dev-python/feedparser-5.1
	>=dev-python/sqlalchemy-0.7
	dev-python/pyyaml
	dev-python/beautifulsoup:python-2
	dev-python/html5lib
	dev-python/jinja
	dev-python/PyRSS2Gen
	dev-python/pynzb
	dev-python/progressbar
	dev-python/flask
	dev-python/cherrypy
	dev-python/python-dateutil
	>=dev-python/requests-0.10.0
	!=dev-python/requests-0.10.1
"
DEPEND="
	dev-python/setuptools
	test? ( ${RDEPEND} dev-python/nose )
"
RDEPEND+="
	dev-python/setuptools
	deluge? ( net-p2p/deluge )
	transmission? ( dev-python/transmissionrpc )
"

if [[ ${PV} == 9999 ]]; then
	DEPEND+=" dev-python/paver"
else
	S="${WORKDIR}/${MY_P}"
fi

src_prepare() {
	# Prevent setup from grabbing nose from pypi
	sed -e /setup_requires/d \
		-e '/requests/s/, <0.11//' \
		-i pavement.py || die

	if [[ ${PV} == 9999 ]]; then
		# Generate setup.py
		paver generate_setup || die
	fi

	epatch_user
	distutils_src_prepare
}
