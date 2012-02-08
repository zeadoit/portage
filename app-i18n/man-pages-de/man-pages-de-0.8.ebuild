# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-de/man-pages-de-0.8.ebuild,v 1.4 2012/02/08 01:19:54 jer Exp $

MY_PN="manpages-de"

DESCRIPTION="A somewhat comprehensive collection of Linux german man page translations"
HOMEPAGE="http://alioth.debian.org/projects/manpages-de/"
SRC_URI="http://manpages-de.alioth.debian.org/downloads/${MY_PN}-${PV}.tar.bz2"

LICENSE="as-is GPL-2 GPL-3 BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man"
S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	:;
}

src_install() {
	make MANDIR="${D}"/usr/share/man/de install  || die
	dodoc CHANGES README

	# Remove man pages provided by other packages
	#  - shadow
	rm "${D}"/usr/share/man/de/man1/{chsh,groups,login,passwd,newgrp,su}.1*
	#  - man
	rm "${D}"/usr/share/man/de/man1/{apropos,man,whatis}.1*
	#  - man-db
	rm "${D}"/usr/share/man/de/man1/{manpath,zsoelim}.1*
	rm "${D}"/usr/share/man/de/man5/manpath.5*
	rm "${D}"/usr/share/man/de/man8/{catman,mandb}.8*
}
