# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/samuel/samuel-0.3.3.ebuild,v 1.1 2012/07/08 11:11:08 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="An automatic logger for HTTP requests in Ruby."
HOMEPAGE="http://github.com/chrisk/samuel"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

ruby_add_bdepend "
	test? (
		>=dev-ruby/shoulda-2.11.3
		>=dev-ruby/fakeweb-1.3
		>=dev-ruby/httpclient-2.2.3
		>=dev-ruby/mocha-0.10.0
		virtual/ruby-test-unit
	)"

all_ruby_prepare() {
	# Remove references to bundler
	sed -i -e '/[Bb]undler/d' test/test_helper.rb || die
	rm Gemfile*

	# Change the default port from 8000 to 64888 to sidestep Issue #10.
	# https://github.com/chrisk/samuel/issues/10
	sed -i -e 's:8000:64888:g' test/*.rb || die
}
