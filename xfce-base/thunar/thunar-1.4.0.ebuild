# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/thunar/thunar-1.4.0.ebuild,v 1.1 2012/04/29 10:13:48 ssuominen Exp $

EAPI=4
inherit virtualx xfconf

MY_P=${P/t/T}

DESCRIPTION="File manager for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/ http://thunar.xfce.org/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="+dbus debug exif libnotify pcre startup-notification test +xfce_plugins_trash udev"

GVFS_DEPEND=">=gnome-base/gvfs-1.10.1"
COMMON_DEPEND=">=dev-lang/perl-5.6
	>=dev-libs/glib-2.24
	>=x11-libs/gtk+-2.20:2
	>=xfce-base/exo-0.8
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10
	dbus? ( >=dev-libs/dbus-glib-0.98 )
	exif? ( >=media-libs/libexif-0.6.19 )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	pcre? ( >=dev-libs/libpcre-6 )
	startup-notification? ( x11-libs/startup-notification )
	udev? ( || ( >=sys-fs/udev-171-r5[gudev] <sys-fs/udev-171[extras] ) )
	xfce_plugins_trash? ( >=xfce-base/xfce4-panel-4.10 )"
RDEPEND="${COMMON_DEPEND}
	>=dev-util/desktop-file-utils-0.20-r1
	x11-misc/shared-mime-info
	dbus? ( ${GVFS_DEPEND} )
	udev? ( ${GVFS_DEPEND}[gdu,udev] )
	xfce_plugins_trash? ( ${GVFS_DEPEND} )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"
REQUIRED_USE="xfce_plugins_trash? ( dbus )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable dbus)
		$(use_enable startup-notification)
		$(use_enable udev gudev)
		$(use_enable libnotify notifications)
		$(xfconf_use_debug)
		$(use_enable exif)
		$(use_enable pcre)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	use xfce_plugins_trash || XFCONF+=( --disable-tpa-plugin )

	DOCS=( AUTHORS ChangeLog FAQ HACKING NEWS README THANKS TODO )
}

src_test() {
	Xemake check
}
