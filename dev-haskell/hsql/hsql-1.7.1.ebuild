# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql/hsql-1.7.1.ebuild,v 1.1 2009/08/05 18:07:58 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Simple library for database access from Haskell."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hsql"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

pkg_postinst () {
	ghc-package_pkg_postinst

	elog "You will probably want to emerge one or more HSQL backend."
	elog "These backends are available:"
	elog "		hsql-postgresql"
	elog "		hsql-mysql"
	elog "		hsql-sqlite"
	elog "		hsql-odbc"
}