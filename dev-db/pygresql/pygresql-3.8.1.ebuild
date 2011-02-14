# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pygresql/pygresql-3.8.1.ebuild,v 1.13 2011/02/13 18:39:12 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="PyGreSQL-${PV}"

DESCRIPTION="A Python interface for the PostgreSQL database."
HOMEPAGE="http://www.pygresql.org/"
SRC_URI="ftp://ftp.pygresql.org/pub/distrib/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc sparc x86"
IUSE="doc"

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}
		dev-python/egenix-mx-base"

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
PYTHON_MODNAME="pg.py pgdb.py"

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/tutorial
		doins tutorial/* || die "doins failed"
		dohtml docs/*.{html,css} || die "dohtml failed"
	fi
}
