# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Base/Test-Base-0.56.ebuild,v 1.2 2009/03/15 13:25:04 ranger Exp $

EAPI=2

MODULE_AUTHOR=INGY
inherit perl-module

DESCRIPTION="A Data Driven Testing Framework"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-Test-Simple-0.62
	>=dev-perl/Spiffy-0.30
	dev-perl/Test-Deep"
RDEPEND="${DEPEND}"

SRC_TEST="do"
