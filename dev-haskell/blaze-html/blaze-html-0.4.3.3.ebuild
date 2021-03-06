# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/blaze-html/blaze-html-0.4.3.3.ebuild,v 1.1 2012/04/07 05:16:48 gienah Exp $

# ebuild generated by hackport 0.2.17.9999

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A blazingly fast HTML combinator library for Haskell"
HOMEPAGE="http://jaspervdj.be/blaze"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-haskell/blaze-builder-0.2[profile?] <dev-haskell/blaze-builder-0.4[profile?]
		>=dev-haskell/text-0.10[profile?] <dev-haskell/text-0.12[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? (
			=dev-haskell/hunit-1.2*
			=dev-haskell/quickcheck-2.4*
			>=dev-haskell/test-framework-0.4 <dev-haskell/test-framework-0.7
			=dev-haskell/test-framework-hunit-0.2*
			=dev-haskell/test-framework-quickcheck2-0.2*
		)"

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}
