# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyberjack/cyberjack-3.99.5_p03-r1.ebuild,v 1.1 2012/08/12 11:26:26 ssuominen Exp $

EAPI=4
inherit eutils linux-info toolchain-funcs

MY_P=pcsc-${PN}_${PV/_p/final.SP}

DESCRIPTION="REINER SCT cyberJack pinpad/e-com USB user space driver library"
HOMEPAGE="http://www.reiner-sct.de/ http://www.libchipcard.de/"
SRC_URI="http://support.reiner-sct.de/downloads/LINUX/V${PV/_p/_SP}/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fox kernel_linux xml"

COMMON_DEPEND="sys-apps/pcsc-lite
	virtual/libusb:1
	fox? ( >=x11-libs/fox-1.6 )
	xml? ( dev-libs/libxml2 )"
RDEPEND="${COMMON_DEPEND}
	kernel_linux? ( sys-fs/udev )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P/_/-}

DOCS="ChangeLog NEWS doc/*.txt"

pkg_setup() {
	if use kernel_linux; then
		CONFIG_CHECK="~USB_SERIAL_CYBERJACK"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc47.patch
}

src_configure() {
	econf \
		--mandir=/usr/share/man/man8 \
		--sysconfdir=/etc/${PN} \
		--disable-hal \
		--enable-pcsc \
		$(use_enable xml xml2) \
		$(use_enable fox) \
		--with-usbdropdir="$($(tc-getPKG_CONFIG) libpcsclite --variable=usbdropdir)"
}

src_install() {
	default

	rm -f "${ED}"usr/lib*/cyberjack/pcscd_init.diff

	prune_libtool_files --all

	# http://bugs.gentoo.org/388329
	if use kernel_linux; then
		local udevdir=/lib/udev
		has_version sys-fs/udev && udevdir="$($(tc-getPKG_CONFIG) --variable=udevdir udev)"
		insinto "${udevdir}"/rules.d
		newins "${FILESDIR}"/${PN}.rules 92-${PN}.rules
	fi
}

pkg_postinst() {
	local conf="${EROOT}/etc/${PN}/${PN}.conf"
	elog
	elog "To configure logging, key beep behaviour etc. you need to"
	elog "copy ${conf}.default"
	elog "to ${conf}"
	elog "and modify the latter as needed."
	elog
}
