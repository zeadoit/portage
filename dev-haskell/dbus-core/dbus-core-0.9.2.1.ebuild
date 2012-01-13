# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/dbus-core/dbus-core-0.9.2.1.ebuild,v 1.1 2012/01/12 17:10:56 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Low-level D-Bus protocol implementation"
HOMEPAGE="https://john-millikin.com/software/dbus-core/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/binary-0.4
		<dev-haskell/binary-0.6
		>=dev-haskell/data-binary-ieee754-0.3
		<dev-haskell/data-binary-ieee754-0.5
		=dev-haskell/libxml-sax-0.7*
		>=dev-haskell/network-2.2
		<dev-haskell/network-2.4
		>=dev-haskell/parsec-2.0
		<dev-haskell/parsec-3.2
		>=dev-haskell/text-0.11.1.5
		<dev-haskell/text-0.12
		>=dev-haskell/vector-0.7
		<dev-haskell/vector-0.10
		=dev-haskell/xml-types-0.3*
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	if has_version "<dev-haskell/haddock-2.9.2"; then
		# Workaround http://hackage.haskell.org/trac/hackage/ticket/626
		# The haddock --hoogle option does not like unicode characters, which causes
		# haddock 2.7.2 to fail like:
		# haddock: internal Haddock or GHC error: dist/doc/html/enumerator/enumerator.txt: commitAndReleaseBuffer: invalid argument (Invalid or incomplete multibyte or wide character)
		sed -e 's@&#8208;@-@g' \
			-e "s@&#8217;@'@g" \
			-i "${S}/hs/DBus/Connection.hs" \
			-i "${S}/hs/DBus/Client/Internal.hs" \
			-i "${S}/hs/DBus/Client/Simple.hs" \
			-i "${S}/hs/DBus/Message/Internal.hs" \
			-i "${S}/hs/DBus/Types/Internal.hs" \
			-i "${S}/hs/DBus/Wire/Internal.hs"
	fi
}
