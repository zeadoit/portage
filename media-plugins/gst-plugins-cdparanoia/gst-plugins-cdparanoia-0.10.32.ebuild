# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.32.ebuild,v 1.5 2011/06/09 16:03:42 jer Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}"
