# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/zentest/zentest-4.1.3.ebuild,v 1.6 2010/05/22 16:07:19 flameeyes Exp $

inherit gems

MY_P=${P/zentest/ZenTest}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ZenTest provides tools to support testing: zentest, unit_diff, autotest, multiruby, and Test::Rails"
HOMEPAGE="http://rubyforge.org/projects/zentest/"
LICENSE="Ruby"

SRC_URI="mirror://rubygems/${MY_P}.gem"

KEYWORDS="amd64 ia64 ppc ppc64 ~sparc x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/rubygems-1.3.0"

pkg_postinst() {
	ewarn "Since 4.1.1 ZenTest no longer bundles support to run autotest Rails projects."
	ewarn "Please install dev-ruby/autotest-rails to add Rails support to autotest."
}
