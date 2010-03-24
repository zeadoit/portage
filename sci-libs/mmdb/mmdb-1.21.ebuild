# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmdb/mmdb-1.21.ebuild,v 1.1 2010/02/02 19:17:56 jlec Exp $

EAPI="2"

DESCRIPTION="The Coordinate Library is designed to assist CCP4 developers in working with coordinate files"
HOMEPAGE="http://www.ebi.ac.uk/~keb/cldoc/"
SRC_URI="http://www.ysbl.york.ac.uk/~emsley/software/${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	!<sci-libs/ccp4-libs-6.1.3
	!sci-biology/ncbi-tools++"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}