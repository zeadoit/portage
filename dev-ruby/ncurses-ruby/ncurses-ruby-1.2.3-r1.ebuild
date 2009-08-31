# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ncurses-ruby/ncurses-ruby-1.2.3-r1.ebuild,v 1.1 2009/08/30 09:14:33 graaff Exp $

inherit ruby

DESCRIPTION="Ruby wrappers of ncurses and PDCurses libs"
HOMEPAGE="http://ncurses-ruby.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
USE_RUBY="ruby18 ruby19"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

DEPEND=">=sys-libs/ncurses-5.3"
RDEPEND="${DEPEND}"

dofakegemspec() {
		cat - > "${T}"/ncurses-${PV}.gemspec <<EOF
Gem::Specification.new do |s|
  s.name = "ncurses"
  s.version = "${PV}"
  s.summary = "${DESCRIPTION}"
  s.homepage = "${HOMEPAGE}"
end
EOF

		insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["vendorlibdir"]' | sed -e 's:vendor_ruby:gems:')/specifications
		doins "${T}"/ncurses-${PV}.gemspec || die "Unable to install fake gemspec"
}

src_install() {
	ruby_src_install
	dofakegemspec
}
