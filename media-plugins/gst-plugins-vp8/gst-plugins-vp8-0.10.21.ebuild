# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.21.ebuild,v 1.1 2011/04/13 10:27:20 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libvpx
	>=media-libs/gst-plugins-base-0.10.32
	>=media-libs/gst-plugins-bad-${PV}" # uses basevideo
DEPEND="${RDEPEND}"
