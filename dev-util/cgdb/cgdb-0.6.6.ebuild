# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cgdb/cgdb-0.6.6.ebuild,v 1.5 2012/06/14 16:28:12 xarthisius Exp $

EAPI=4

DESCRIPTION="A curses front-end for GDB, the GNU debugger"
HOMEPAGE="http://cgdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/cgdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux"
IUSE=""

DEPEND="sys-libs/ncurses
	>=sys-libs/readline-5.1-r2"
RDEPEND="${DEPEND}
	sys-devel/gdb"
