# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fslsfonts/fslsfonts-1.0.2.ebuild,v 1.2 2008/09/24 09:18:10 aballier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="list fonts served by X font server"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}"
