# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql-postgresql/hsql-postgresql-1.8.2.ebuild,v 1.1 2012/04/15 11:14:47 gienah Exp $

# ebuild generated by hackport 0.2.13

EAPI=4

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="A Haskell Interface to PostgreSQL via the PQ library."
HOMEPAGE="http://hackage.haskell.org/package/hsql-postgresql"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hsql-1.8.2[profile?]
		<dev-haskell/hsql-1.9[profile?]
		>=dev-lang/ghc-6.10.1
		>=dev-db/postgresql-base-7"
DEPEND="${RDEPEND}
		dev-haskell/cabal"
