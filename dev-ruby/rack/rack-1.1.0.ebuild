# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack/rack-1.1.0.ebuild,v 1.1 2010/01/04 18:53:22 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="A modular Ruby webserver interface"
HOMEPAGE="http://rubyforge.org/projects/rack"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-solaris"
IUSE=""

# The gem has automagic dependencies over mongrel, ruby-openid,
# memcache-client, thin and camping; not sure if we should make them
# dependencies at all.
ruby_add_bdepend test dev-ruby/test-spec

# Since the Rakefile calls specrb directly rather than loading it, we
# cannot use it to launch the tests or only the currently-selected
# RUBY interpreter will be tested.
each_ruby_test() {
	${RUBY} -S specrb -Ilib:test -w -a \
		-t  '^(?!Rack::Handler|Rack::Adapter|Rack::Session::Memcache|rackup)' \
		|| die "test failed for ${RUBY}"
}

all_ruby_install() {
	all_fakegem_install

	ruby_fakegem_binwrapper rackup
}