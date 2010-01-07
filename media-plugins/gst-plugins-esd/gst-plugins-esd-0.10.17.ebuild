# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-esd/gst-plugins-esd-0.10.17.ebuild,v 1.1 2009/11/17 03:57:51 leio Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to output sound to esound"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-sound/esound-0.2.12
	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25"