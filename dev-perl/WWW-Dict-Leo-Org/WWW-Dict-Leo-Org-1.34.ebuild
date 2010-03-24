# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Dict-Leo-Org/WWW-Dict-Leo-Org-1.34.ebuild,v 1.2 2010/02/12 16:12:14 jlec Exp $

MODULE_AUTHOR="TLINDEN"
inherit perl-app

DESCRIPTION="commandline interface to http://dict.leo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-lang/perl
	dev-perl/HTML-TableParser
	!app-editors/leo"
DEPEND="${RDEPEND}"