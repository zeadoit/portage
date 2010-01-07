# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgintex/pidgintex-1.1.1.ebuild,v 1.1 2009/12/21 20:39:14 pva Exp $

EAPI="2"
inherit toolchain-funcs multilib

MY_P=pidginTeX-${PV}

DESCRIPTION="Pidgin plugin to render LaTeX expressions in messages."
HOMEPAGE="http://code.google.com/p/pidgintex"
SRC_URI="http://pidgintex.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/pidgin[gtk]
	app-text/mathtex"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e "s:\(^CC.*=\).*:\1 $(tc-getCC):" \
		-e "s:\(^STRIP.*=\).*:\1 true:" \
		-e "s:\(^CFLAGS[[:space:]]*\)=:\1+=:" \
		-e "/LIB_INSTALL_DIR/{s:/lib/purple-2:/$(get_libdir)/pidgin:;}" \
			-i Makefile || die
	# set default renderer to mathtex
	sed -e "/purple_prefs_add_string.*PREFS_RENDERER/{s:mimetex:mathtex:;}" \
		-i pidginTeX.c || die
}

src_compile() {
	emake PREFIX=/usr || die
}

src_install() {
	make PREFIX="${D}/usr" install || die "make install failed"
	dodoc CHANGELOG README TODO || die
}