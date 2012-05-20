# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mscompress/mscompress-0.3.ebuild,v 1.22 2012/05/20 09:03:33 halcy0n Exp $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Microsoft compress.exe/expand.exe compatible (de)compressor"
HOMEPAGE="http://gnuwin32.sourceforge.net/packages/mscompress.htm"
SRC_URI="ftp://ftp.penguin.cz/pub/users/mhi/mscompress/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-amd64.patch
}

src_configure() {
	tc-export CC
	[[ $(tc-arch) == ppc* ]] && append-flags -fsigned-char
	econf
}

src_install() {
	dobin mscompress msexpand || die
	doman mscompress.1 msexpand.1
	dodoc README ChangeLog
}
