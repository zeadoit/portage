# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/skrooge/skrooge-0.8.1.ebuild,v 1.1 2011/03/17 11:09:41 scarabeus Exp $

EAPI=4
KDE_LINGUAS="bg ca ca@valencia cs da de el en_GB eo es et fr ga gl hu it ja ko lt ms nb
nds nl pl pt pt_BR ro ru sk sv tr uk zh_TW"
KDE_DOC_DIRS="doc"
VIRTUALX_REQUIRED=test
inherit kde4-base

DESCRIPTION="personal finances manager for KDE4, aiming at being simple and intuitive"
HOMEPAGE="http://skrooge.org/"
SRC_URI="http://skrooge.org/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook test"

DEPEND=">=dev-libs/libofx-0.9.1
	app-crypt/qca:2
	x11-libs/qt-sql:4[sqlite]"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesdk-scripts)"

# Quite few tests fail in all versions
# Upstream does not seem to be bothered by the fact release fails tests
RESTRICT="test"

DOCS="AUTHORS CHANGELOG README TODO"

src_configure() {
	mycmakeargs+=( $(cmake-utils_use test SKG_BUILD_TEST) )
	kde4-base_src_configure
}
