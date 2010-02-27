# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-maven/eselect-maven-0.1-r1.ebuild,v 1.1 2010/02/26 17:17:37 grobian Exp $

EAPI=3

DESCRIPTION="Manages Maven symlinks"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.8
	!<dev-java/maven-bin-2.0.10-r1:2.1"
PDEPEND="
|| (
	dev-java/maven-bin:2.2
	dev-java/maven-bin:2.1
	dev-java/maven-bin:2.0
)"

src_unpack() {
	mkdir "${S}"
	cp "${FILESDIR}"/maven.eselect-1 "${S}"/maven.eselect || die
}

src_install() {
	insinto /usr/share/eselect/modules
	doins "${S}"/maven.eselect || die
}
