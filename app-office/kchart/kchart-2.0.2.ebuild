# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kchart/kchart-2.0.2.ebuild,v 1.1 2009/08/12 10:02:53 scarabeus Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice chart application."

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/
	interfaces/
	filters/
	plugins/
"
KMEXTRA="
	filters/${KMMODULE}/
"

KMLOADLIBS="koffice-libs"
