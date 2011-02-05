# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.8.1.ebuild,v 1.4 2011/02/05 18:11:18 maekke Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce's basic utilities library"
HOMEPAGE="http://www.xfce.org/projects/libraries/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.8/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.12:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		--disable-static
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
}
