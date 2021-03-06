# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aiccu/aiccu-2007.01.15-r2.ebuild,v 1.2 2012/08/01 13:32:14 xmw Exp $

EAPI=4

inherit eutils linux-info toolchain-funcs

DESCRIPTION="AICCU Client to configure an IPv6 tunnel to SixXS"
HOMEPAGE="http://www.sixxs.net/tools/aiccu"
SRC_URI="http://www.sixxs.net/archive/sixxs/aiccu/unix/${PN}_${PV//\./}.tar.gz"

LICENSE="SixXS"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-libs/gnutls
	sys-apps/iproute2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/aiccu

CONFIG_CHECK="~TUN"

src_prepare() {
	epatch "${FILESDIR}"/${PF}-init.gentoo.patch
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-setupscript.patch
	epatch "${FILESDIR}"/${P}-uclibc.patch
}

src_compile() {
	# Don't use main Makefile since it requires additional
	# dependencies which are useless for us.
	emake CC=$(tc-getCC) STRIP= -C unix-console
}

src_install() {
	dosbin unix-console/${PN}

	insopts -m 600
	insinto /etc
	doins doc/${PN}.conf
	newinitd doc/${PN}.init.gentoo ${PN}

	dodoc doc/{HOWTO,README,changelog}
}
