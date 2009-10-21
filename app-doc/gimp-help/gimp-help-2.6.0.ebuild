# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-help/gimp-help-2.6.0.ebuild,v 1.1 2009/10/20 13:29:23 pva Exp $

inherit eutils

DESCRIPTION="GNU Image Manipulation Program help files"
HOMEPAGE="http://docs.gimp.org/"

LICENSE="FDL-1.2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE=""

# Only *not* outdated translations (see, configure.ac) are listed.
# On update do not forgive to check quickreference/Makefile.am for
# QUICKREFERENCE_ALL_LINGUAS. LANGS should include that langs too.
LANGS="de en es fr it ja ko nl nn pl ru sv zh_CN"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://gimp/help/${P}-html-${X}.tar.bz2 )"
done

DEPEND=""
RDEPEND=">=media-gfx/gimp-2.4"

S=${WORKDIR}/gimp-help-2/

src_compile() { :; }

src_install() {
	insinto /usr/share/gimp/2.0/help
	doins -r html/*
	dodoc AUTHORS HACKING MAINTAINERS README
}