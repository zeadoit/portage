# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Fatal/Test-Fatal-0.9.0.ebuild,v 1.1 2012/02/12 19:52:47 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.009
inherit perl-module

DESCRIPTION="Incredibly simple helpers for testing code with exceptions"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Try-Tiny-0.70.0"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.30
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
