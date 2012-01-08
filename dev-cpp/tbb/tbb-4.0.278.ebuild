# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tbb/tbb-4.0.278.ebuild,v 1.2 2012/01/07 20:47:39 bicatali Exp $

EAPI=4
inherit eutils versionator toolchain-funcs

# those 2 below change pretty much every release
# url number
MYU="78/179"
# release update
MYR="%20update%202"

PV1="$(get_version_component_range 1)"
PV2="$(get_version_component_range 2)"
PV3="$(get_version_component_range 3)"
MYP="${PN}${PV1}${PV2}_${PV3}oss"

DESCRIPTION="High level abstract threading library"
HOMEPAGE="http://www.threadingbuildingblocks.org/"
SRC_URI="http://www.threadingbuildingblocks.org/uploads/${MYU}/${PV1}.${PV2}${MYR}/${MYP}_src.tgz"
LICENSE="GPL-2-with-exceptions"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples"

DEPEND="!<=dev-cpp/tbb-2.1.016"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0.104-tests.patch
	# use fully qualified compilers. do not force pentium4 for x86 users
	local CC="$(tc-getCC)"
	sed -i \
		-e "s/-O2/${CXXFLAGS}/g" \
		-e 's/^\(CPLUS = \)g++ $/\1'"$(tc-getCXX)/" \
		-e 's/^\(CONLY = \)gcc$/\1'"${CC}/" \
		-e 's/\(shell \)gcc\( --version\)/\1'"${CC}"'\2/' \
		-e '/CPLUS_FLAGS +=/s/-march=pentium4//' \
		build/*.inc || die
	# - Strip the $(shell ... >$(NUL) 2>$(NUL)) wrapping, leaving just the
	#   actual command.
	# - Force generation of version_string.tmp immediately after the directory
	#   is created.  This avoids a race when the user builds tbb and tbbmalloc
	#   concurrently.  The choice of Makefile.tbb (instead of
	#   Makefile.tbbmalloc) is arbitrary.
	sed -i \
		-e 's/^\t\$(shell \(.*\) >\$(NUL) 2>\$(NUL))\s*/\t\1/' \
		-e 's!^\t@echo Created \$(work_dir)_\(debug\|release\).*$!&\n\t$(MAKE) -C "$(work_dir)_\1"  -r -f $(tbb_root)/build/Makefile.tbb cfg=\1 tbb_root=$(tbb_root) version_string.tmp!' \
		src/Makefile || die
	find include -name \*.html -delete
}

src_compile() {
	if [[ $(tc-getCXX) == *g++ ]]; then
		myconf="compiler=gcc"
	elif [[ $(tc-getCXX) == *ic*c ]]; then
		myconf="compiler=icc"
	fi
	local ccconf="${myconf}"
	if use debug || use examples; then
		ccconf="${ccconf} tbb_debug tbbmalloc_debug"
	fi
	emake -C src ${ccconf} tbb_release tbbmalloc_release
}

src_test() {
	local ccconf="${myconf}"
	if use debug || use examples; then
		${ccconf}="${myconf} test_debug tbbmalloc_test_debug"
	fi
	emake -C src ${ccconf} test_release
}

src_install(){
	for l in $(find build -name lib\*.so.\*); do
		dolib.so ${l}
		local bl=$(basename ${l})
		dosym ${bl} /usr/$(get_libdir)/${bl%.*}
	done
	insinto /usr
	doins -r include

	dodoc README CHANGES doc/Release_Notes.txt
	use doc && dohtml -r doc/html/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples/build
		doins build/*.inc
		insinto /usr/share/doc/${PF}/examples
		doins -r examples
	fi
}
