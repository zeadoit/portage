# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/virtuoso-odbc/virtuoso-odbc-6.1.0.ebuild,v 1.2 2010/02/10 07:08:30 abcd Exp $

EAPI="3"

inherit virtuoso

DESCRIPTION="ODBC driver for OpenLink Virtuoso Open-Source Edition"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND="
	>=dev-libs/openssl-0.9.7i:0
"
DEPEND="${RDEPEND}"

VOS_EXTRACT="
	libsrc/Dk
	libsrc/Thread
	libsrc/odbcsdk
	libsrc/util
	binsrc/driver
"

src_configure() {
	myconf+="
		$(use_enable static-libs static)
		--without-iodbc
	"

	virtuoso_src_configure
}

src_install() {
	virtuoso_src_install

	# Remove libtool files
	if ! use static-libs; then
		local libdir
		for libdir in $(get_all_libdirs); do
			rm -f "${ED}/usr/${libdir}"/*.la || die
		done
	fi
}
