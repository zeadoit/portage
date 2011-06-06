# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Share/Horde_Share-1.1.0.ebuild,v 1.1 2011/06/04 19:55:51 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Horde Shared Permissions System"
LICENSE="LGPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/${P}.tgz"

DEPEND=">=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	=dev-php/Horde_Db-1*
	=dev-php/Horde_Exception-1*
	=dev-php/Horde_Group-1*
	=dev-php/Horde_Perms-1*
	=dev-php/Horde_Support-1*
	=dev-php/Horde_Translation-1*
	=dev-php/Horde_Url-1*
	=dev-php/Horde_Util-1*"
RDEPEND="${DEPEND}"
