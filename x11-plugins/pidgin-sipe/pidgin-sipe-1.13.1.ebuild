# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-sipe/pidgin-sipe-1.13.1.ebuild,v 1.2 2012/06/26 19:53:26 thev00d00 Exp $

EAPI=4

DESCRIPTION="Pidgin Plug-in SIPE (Sip Exchange Protocol)"
HOMEPAGE="http://sipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/sipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kerberos voice"

RDEPEND="net-im/pidgin[gnutls]
	>=dev-libs/gmime-2.4.16
	dev-libs/libxml2
	kerberos? ( app-crypt/mit-krb5 )
	voice? (
		>=dev-libs/glib-2.28.0
		>=net-libs/libnice-0.1.0
		media-libs/gstreamer )
	!voice? ( >=dev-libs/glib-2.12.0 )
"

DEPEND="dev-util/intltool
	${RDEPEND}
"

src_configure() {
	econf \
		--enable-purple \
		--disable-quality-check \
		--disable-telepathy \
		$(use_with voice vv) \
		$(use_enable debug) \
		$(use_with kerberos krb5)
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS TODO README
}
