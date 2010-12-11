# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbacklight/xbacklight-1.1.2.ebuild,v 1.1 2010/12/10 19:15:36 scarabeus Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Sets backlight level using the RandR 1.2 BACKLIGHT output property"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libXrandr-1.2
	x11-libs/libX11"
DEPEND="${RDEPEND}"
