# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-1.1.0.ebuild,v 1.1 2012/01/07 21:41:50 naota Exp $

EAPI="3"
USE_RUBY="ruby18 ree18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="${RDEPEND} >=dev-libs/glib-2"
DEPEND="${DEPEND}
	>=dev-libs/glib-2"

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf.rb failed"
}
