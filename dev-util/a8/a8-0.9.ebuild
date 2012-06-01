# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/a8/a8-0.9.ebuild,v 1.1 2012/06/01 06:22:56 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils eutils gnome2-utils

DESCRIPTION="An ultra-lightweight IDE, that embeds Vim, a terminal emulator, and a file browser"
HOMEPAGE="http://code.google.com/p/abominade/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/argparse
	>=dev-python/dbus-python-1
	dev-python/logbook
	dev-python/psutil
	dev-python/pyyaml
	>=dev-python/pygtk-2.22
	>=dev-python/pygtkhelpers-0.4.3
	x11-libs/vte:0[python]"
RDEPEND="${DEPEND}
	app-editors/gvim"

src_install() {
	distutils_src_install

	insinto /usr/share/icons/hicolor/48x48/apps
	doins a8/data/icons/a8.png

	make_desktop_entry ${PN} ${PN} ${PN} 'Development;IDE'
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils_pkg_postrm
}
