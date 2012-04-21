# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-gvfs-mount/xfce4-gvfs-mount-0.0.4.ebuild,v 1.4 2012/04/21 05:51:32 ssuominen Exp $

EAPI=4
inherit multilib xfconf

MY_REV=6d2684b

DESCRIPTION="A panel plug-in to mount remote filesystems for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-gvfs-mount"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}-${MY_REV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.24
	>=gnome-base/libglade-2.6
	>=x11-libs/gtk+-2.20:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

S=${WORKDIR}/${P}-${MY_REV}

pkg_setup() {
	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		)

	DOCS=( AUTHORS NEWS README )
}
