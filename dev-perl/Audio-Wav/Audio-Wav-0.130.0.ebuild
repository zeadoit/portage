# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.130.0.ebuild,v 1.5 2012/08/09 17:45:56 ranger Exp $

EAPI=4

MODULE_AUTHOR=BRIANSKI
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="Modules for reading & writing Microsoft WAV files."

SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc x86"
IUSE=""

RDEPEND="dev-perl/Inline"
DEPEND="${RDEPEND}"

SRC_TEST="do"
