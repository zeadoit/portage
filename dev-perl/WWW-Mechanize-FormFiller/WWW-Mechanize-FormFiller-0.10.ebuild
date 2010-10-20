# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize-FormFiller/WWW-Mechanize-FormFiller-0.10.ebuild,v 1.3 2010/10/20 11:16:14 phajdan.jr Exp $

EAPI=2

MODULE_AUTHOR=CORION
inherit perl-module

DESCRIPTION="Framework to automate HTML forms "

SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

DEPEND="dev-perl/Data-Random
	dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
