# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-timer/php-timer-1.0.2.ebuild,v 1.3 2012/02/21 14:56:47 ago Exp $

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.phpunit.de"
PHP_PEAR_PN="PHP_Timer"

inherit php-pear-lib-r1

DESCRIPTION="Utility class for timing"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
HOMEPAGE="http://pear.phpunit.de/"
