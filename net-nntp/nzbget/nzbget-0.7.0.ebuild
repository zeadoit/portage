# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nzbget/nzbget-0.7.0.ebuild,v 1.8 2012/06/17 08:34:43 radhermit Exp $

EAPI="2"

inherit eutils autotools user

MY_P="${P/_pre/-testing-r}"

DESCRIPTION="A command-line based binary newsgrapper supporting .nzb files"
HOMEPAGE="http://nzbget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE="debug ssl gnutls ncurses parcheck"

RDEPEND="dev-libs/libxml2
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
	)
	ncurses? ( sys-libs/ncurses )
	parcheck? (
		app-arch/libpar2
		dev-libs/libsigc++:2
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/${P/_pre*/-testing}

src_prepare() {
	sed \
		-i \
		-e 's:^PostProcess=.*:#PostProcess=/usr/share/nzbget/postprocess-example.sh:' \
		nzbget.conf.example \
		|| die "sed nzbget.conf.example failed"

	sed \
		-e 's:^$MAINDIR=.*:$MAINDIR=/var/lib/nzbget:' \
		-e 's:^LockFile=.*:LockFile=/var/run/nzbget/nzbget.pid:' \
		-e 's:^LogFile=.*:LogFile=/var/log/nzbget/nzbget.log:' \
		"${S}"/nzbget.conf.example >"${S}"/nzbgetd.conf.example \
		|| die "sed nzbgetd.conf.example failed"

	epatch "${FILESDIR}"/${P}-openssl-1.patch \
		"${FILESDIR}"/${P}-underlinking.patch

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable ncurses curses) \
		$(use_enable parcheck) \
		$(use_enable ssl tls) \
		--with-tlslib=$(use gnutls && echo GnuTLS || echo OpenSSL) \
	|| die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	insinto /etc
	newins nzbget.conf.example nzbget.conf || die "newins failed"
	newins nzbgetd.conf.example nzbgetd.conf || die "newins failed"

	keepdir /var/lib/nzbget/{dst,nzb,queue,tmp}
	keepdir /var/{log,run}/nzbget

	newinitd "${FILESDIR}"/nzbget.initd nzbget
	newconfd "${FILESDIR}"/nzbget.confd nzbget

	exeinto /usr/share/nzbget
	doexe postprocess-example.sh

	insinto /usr/share/nzbget
	doins postprocess-example.conf

	dodoc AUTHORS ChangeLog README nzbget.conf.example || die "dodoc failed"
}

pkg_preinst() {
	enewgroup nzbget
	enewuser nzbget -1 -1 /var/lib/nzbget nzbget

	fowners nzbget:nzbget /var/lib/nzbget/{dst,nzb,queue,tmp}
	fperms 750 /var/lib/nzbget/{queue,tmp}
	fperms 770 /var/lib/nzbget/{dst,nzb}

	fowners nzbget:nzbget /var/{log,run}/nzbget
	fperms 750 /var/{log,run}/nzbget

	fowners root:nzbget /etc/nzbgetd.conf
	fperms 640 /etc/nzbgetd.conf
}

pkg_postinst() {
	elog
	elog "Please add users that you want to be able to use the system-wide"
	elog "nzbget daemon to the nzbget group. To access the daemon run nzbget"
	elog "with the --configfile /etc/nzbgetd.conf option."
	elog
}
