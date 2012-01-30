# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcyrillic/texlive-langcyrillic-2011.ebuild,v 1.5 2012/01/29 19:30:06 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="cmcyr cyrillic cyrillic-bin cyrplain disser eskd eskdx gost lcyw lh lhcyr ruhyphen russ t2 ukrhyph hyphen-bulgarian hyphen-russian hyphen-ukrainian collection-langcyrillic
"
TEXLIVE_MODULE_DOC_CONTENTS="cmcyr.doc cyrillic.doc cyrillic-bin.doc disser.doc eskd.doc eskdx.doc gost.doc lcyw.doc lh.doc russ.doc t2.doc ukrhyph.doc "
TEXLIVE_MODULE_SRC_CONTENTS="cyrillic.source disser.source eskd.source gost.source lcyw.source lh.source lhcyr.source ruhyphen.source "
inherit  texlive-module
DESCRIPTION="TeXLive Cyrillic"

LICENSE="GPL-2 as-is LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
>=dev-texlive/texlive-latex-2011
"
RDEPEND="${DEPEND} "
