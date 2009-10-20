# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler-utils/poppler-utils-0.12.1.ebuild,v 1.2 2009/10/19 19:35:30 aballier Exp $

EAPI=2

POPPLER_MODULE=utils

inherit poppler

DESCRIPTION="PDF conversion utilities"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="+abiword png"

RDEPEND="
	~dev-libs/poppler-${PV}[abiword?]
	abiword? ( >=dev-libs/libxml2-2.7.2 )
	png? ( >=media-libs/libpng-1.2.35 )
	!app-text/pdftohtml
	"
DEPEND="
	${RDEPEND}
	"

pkg_setup() {
	POPPLER_CONF="
			$(use_enable abiword abiword-output)
			$(use_enable png libpng)
			"
}
