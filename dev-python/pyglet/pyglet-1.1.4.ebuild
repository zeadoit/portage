# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyglet/pyglet-1.1.4.ebuild,v 1.2 2010/11/14 13:15:33 jlec Exp $

EAPI=2

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Cross-platform windowing and multimedia library for Python"
HOMEPAGE="http://www.pyglet.org/"
SRC_URI="http://pyglet.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa doc examples gtk +openal"

RDEPEND="
	virtual/opengl
	alsa? ( media-libs/alsa-lib[alisp] )
	gtk? ( x11-libs/gtk+:2 )
	openal? ( media-libs/openal )"
DEPEND="${REDEPEND}"
#	ffmpeg? ( media-libs/avbin-bin )

DOCS="NOTICE"

src_install() {
	distutils_src_install
	insinto /usr/share/${P}
	if use doc; then
		dohtml -r doc/html || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
