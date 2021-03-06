# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.12.1.ebuild,v 1.4 2012/05/15 23:23:22 aballier Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2 versionator

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="3.10"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc +introspection python"

RDEPEND="dev-libs/atk[introspection?]
	>=dev-libs/glib-2.32:2
	>=dev-libs/libxml2-2.4.0:2
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.4:3[introspection?]
	x11-libs/pango[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.10.1 )
	python? ( >=dev-python/pygobject-2.90.4:3 )
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/gnome-doc-utils-0.18
	app-text/scrollkeeper
	>=dev-util/intltool-0.41.0
	>=sys-devel/gettext-0.17
	virtual/pkgconfig

	dev-libs/gobject-introspection-common
	gnome-base/gnome-common
	doc? ( >=dev-util/gtk-doc-1.13 )
"
# eautoreconf requires:
#	dev-libs/gobject-introspection-common
#	gnome-base/gnome-common

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-static
		--enable-libtool-lock
		--disable-scrollkeeper
		$(use_enable introspection)
		$(use_enable python)"
}

src_prepare() {
	# To avoid file collison with other slots, rename help module.
	# Prevent the UI from loading glade:3's gladeui devhelp documentation.
	epatch "${FILESDIR}/${P}-doc-version.patch"
	eautoreconf
	gnome2_src_prepare
}

src_install() {
	# modify Name in .desktop file to avoid confusion with other slots
	sed -e 's:^\(Name.*=Glade\):\1 '$(get_version_component_range 1-2): \
		-i data/glade.desktop || die "sed of data/glade.desktop failed"
	# modify name in .devhelp2 file to avoid shadowing with glade:3 docs
	sed -e 's:name="gladeui":name="gladeui-2":' \
		-i doc/html/gladeui.devhelp2 || die "sed of gladeui.devhelp2 failed"
	gnome2_src_install
}
