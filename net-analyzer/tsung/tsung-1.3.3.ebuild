# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tsung/tsung-1.3.3.ebuild,v 1.1 2011/03/17 05:17:24 patrick Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Erlang's multi-protocol distributed load testing tool"
HOMEPAGE="http://tsung.erlang-projects.org/"
SRC_URI="http://tsung.erlang-projects.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/erlang"
RDEPEND=${DEPEND}

src_configure() {
	./configure --prefix="/usr" || die "econf failed"
}

src_compile() {
	emake || die "Failed building"
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed installing"
}
