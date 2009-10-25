# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clipboard/Clipboard-0.09.ebuild,v 1.5 2009/10/24 11:52:41 nixnut Exp $

EAPI=2

MODULE_AUTHOR=KING
inherit perl-module

DESCRIPTION="Copy and paste with any OS"

SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="x11-misc/xclip
	dev-perl/Spiffy"
