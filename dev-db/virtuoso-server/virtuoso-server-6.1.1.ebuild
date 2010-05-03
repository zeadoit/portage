# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/virtuoso-server/virtuoso-server-6.1.1.ebuild,v 1.2 2010/05/02 09:44:21 aballier Exp $

EAPI="3"

inherit virtuoso

DESCRIPTION="Server binaries for Virtuoso, high-performance object-relational SQL database"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="kerberos ldap readline static-libs"

RESTRICT="test"

# zeroconf support looks like broken - disabling - last checked around 5.0.12
# mono support fetches mono source and compiles it manually - disabling for now
# mono? ( dev-lang/mono )
COMMON_DEPEND="
	dev-libs/libxml2:2
	>=dev-libs/openssl-0.9.7i:0
	sys-libs/zlib:0
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	readline? ( sys-libs/readline:0 )
"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.33
"
RDEPEND="${COMMON_DEPEND}
	>=dev-db/virtuoso-odbc-${PV}:${SLOT}
"

VOS_EXTRACT="
	libsrc/Dk
	libsrc/Thread
	libsrc/Tidy
	libsrc/Wi
	libsrc/Xml.new
	libsrc/langfunc
	libsrc/odbcsdk
	libsrc/plugin
	libsrc/util
	binsrc/virtuoso
	binsrc/tests
"

src_prepare() {
	if ! use static-libs; then
		sed -e '/^lib_LTLIBRARIES\s*=.*/s/lib_/noinst_/' -i binsrc/virtuoso/Makefile.am \
			|| die "failed to disable installation of static lib"
	fi

	virtuoso_src_prepare
}

src_configure() {
	myconf+="
		$(use_enable kerberos krb)
		$(use_enable ldap openldap)
		$(use_with readline)
		$(use_enable static-libs static)
		--disable-rendezvous
		--disable-hslookup
		--without-iodbc
	"

	virtuoso_src_configure
}

src_install() {
	virtuoso_src_install

	# Rename isql executables (conflicts with unixODBC)
	mv "${ED}/usr/bin/isql" "${ED}/usr/bin/isql-v" || die
	mv "${ED}/usr/bin/isqlw" "${ED}/usr/bin/isqlw-v" || die

	dodoc AUTHORS ChangeLog CREDITS INSTALL NEWS README || die "dodoc failed"

	keepdir /var/lib/virtuoso/db
}
