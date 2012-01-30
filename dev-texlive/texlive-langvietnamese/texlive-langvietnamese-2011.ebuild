# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langvietnamese/texlive-langvietnamese-2011.ebuild,v 1.5 2012/01/29 20:26:45 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="vntex collection-langvietnamese
"
TEXLIVE_MODULE_DOC_CONTENTS="vntex.doc "
TEXLIVE_MODULE_SRC_CONTENTS="vntex.source "
inherit  texlive-module
DESCRIPTION="TeXLive Vietnamese"

LICENSE="GPL-2 as-is "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
"
RDEPEND="${DEPEND} "
