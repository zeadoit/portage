# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sass-rails/sass-rails-3.2.5.ebuild,v 1.2 2012/05/17 10:58:30 tomka Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.markdown"

inherit ruby-fakegem

DESCRIPTION="Official Ruby-on-Rails Integration with Sass"
HOMEPAGE="https://github.com/rails/sass-rails"

LICENSE="MIT"
SLOT="3.2"
KEYWORDS="~amd64 ~x86 ~x64-macos"

IUSE=""

# Restrict tests for now since it is hard to set up the right
# environment with the correct ruby interpreter and Rails test
# application.
RESTRICT="test"

ruby_add_bdepend "test? ( dev-ruby/sfl dev-ruby/bundler )"

ruby_add_rdepend ">=dev-ruby/sass-3.1.10
	dev-ruby/railties:3.2
	dev-ruby/actionpack:3.2
	>=dev-ruby/tilt-1.3.2"

all_ruby_prepare() {
	# Use the released version of Rails, not a git checkout
	sed -i -e 's/:git.*/"~>3.2.0"/' Gemfile || die
}

each_ruby_test() {
	${RUBY} -S bundle exec rake test || die
}
