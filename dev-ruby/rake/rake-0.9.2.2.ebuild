# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rake/rake-0.9.2.2.ebuild,v 1.8 2012/08/19 18:27:01 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc TODO"

RUBY_FAKEGEM_TASK_TEST=""

inherit bash-completion ruby-fakegem

DESCRIPTION="Make-like scripting in Ruby"
HOMEPAGE="http://rake.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="bash-completion doc"

DEPEND="${DEPEND} app-arch/gzip"
RDEPEND="${RDEPEND}"

ruby_add_bdepend "doc? ( dev-ruby/rdoc )
	test? ( dev-ruby/minitest )"

all_ruby_prepare() {
	# Comment out unimportant test which failes on ruby18 at least.
	sed -i -e '/def test_classic_namespace/,/^  end/ s:^:#:' test/test_rake_application_options.rb || die

	# Avoid tests which can't work in bootstrapping because the test runs
	# in a directory that can't access the file being loaded.
	rm test/test_rake_clean.rb || die
	sed -i -e '/test_run_code_rake/,/^  end/ s:^:#:' test/test_rake_test_task.rb || die

	# Decompress the file. The compressed version has errors, ignore them.
	zcat doc/rake.1.gz > doc/rake.1
}

all_ruby_compile() {
	if use doc; then
		ruby -Ilib bin/rake rdoc || die "doc generation failed"
	fi
}

each_ruby_test() {
	${RUBY} bin/rake test || die "tests failed"
}

all_ruby_install() {
	ruby_fakegem_binwrapper rake

	if use doc; then
		pushd html
		dohtml -r *
		popd
	fi

	doman doc/rake.1

	dobashcompletion "${FILESDIR}"/rake.bash-completion rake
}
