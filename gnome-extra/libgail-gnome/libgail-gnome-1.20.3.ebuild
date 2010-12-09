# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgail-gnome/libgail-gnome-1.20.3.ebuild,v 1.10 2010/12/08 17:29:46 pacho Exp $

EAPI="3"
inherit gnome2

DESCRIPTION="Gail libraries for GNOME"
HOMEPAGE="http://live.gnome.org/Accessibility/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/atk-1.7.2
	>=x11-libs/gtk+-1.3.11
	>=gnome-base/libbonobo-1.1
	>=gnome-base/libbonoboui-1.1
	>=gnome-base/libgnomeui-1.1
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=gnome-base/gconf-2
	>=gnome-extra/at-spi-0.10"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"
