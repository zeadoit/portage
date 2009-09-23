# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Console_Getopt/PEAR-Console_Getopt-1.2.3.ebuild,v 1.1 2009/09/23 02:46:59 beandog Exp $

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

inherit depend.php

DESCRIPTION="Command-line option parser"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
PDEPEND="dev-php/pear"
HOMEPAGE="http://pear.php.net/package/Console_Getopt"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	require_php_with_use pcre
}

src_install() {
	insinto /usr/share/php/
	doins -r Console
}
