# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hg-git/hg-git-0.2.6-r1.ebuild,v 1.4 2012/01/15 15:21:08 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="push and pull from a Git server using Mercurial"
HOMEPAGE="http://hg-git.github.com/ http://pypi.python.org/pypi/hg-git"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-vcs/mercurial-1.1
		>=dev-python/dulwich-0.6"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="hggit"

src_prepare() {
	epatch "${FILESDIR}"/${P}-mercurial-1.9-{1,2,3,4}.patch
}
