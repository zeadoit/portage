# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.3.3-r1.ebuild,v 1.3 2010/11/15 13:31:42 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils flag-o-matic multilib toolchain-funcs versionator

MY_PV="${PV//.0}"
MY_PV="${MY_PV//.}"

DESCRIPTION="Powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
DOC_PREFIX="${PN}-${PV}"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip
	doc? ( mirror://gentoo/${DOC_PREFIX}-manual.pdf.bz2 )"

LICENSE="DB"
KEYWORDS="amd64 ~x86"
SLOT="0"
IUSE="doc ldap odbc python"

S="${WORKDIR}"

RDEPEND="sys-libs/zlib
	ldap? ( net-nds/openldap )
	odbc? ( dev-db/unixODBC )
	!dev-python/cryptlib_py"
DEPEND="${RDEPEND}
	app-arch/unzip"
RESTRICT_PYTHON_ABIS="3.*"

src_unpack() {
	# we need the -a option, so we can not use 'unpack'
	unzip -qoa "${DISTDIR}/cl${MY_PV}.zip"
	use doc && unpack "${DOC_PREFIX}-manual.pdf.bz2"
}

src_prepare() {
	rm -fr zlib

	# we want our own CFLAGS ;-)
	sed -i -e "s:-m.*=pentium::g" -e "s:-fomit-frame-pointer::g" -e "s:-O2::g" \
		-e "s:-O3::g" -e "s:-O4::g"	makefile || die "sed makefile failed"
	sed -i -e "s/-march=[[:alnum:]\.=-]*//g" -e "s/-mcpu=[[:alnum:]\.=-]*//g" \
		-e "s:-O2::g" -e "s:-O3::g" tools/ccopts.sh || die "sed tools/ccopts.sh failed"

	# change 'make' to '$(MAKE)'
	sed -i -e "s:@\?make:\$(MAKE):g" makefile || die "sed makefile failed"

	# NOTICE:
	# Because of stack execution
	# assembly parts are disabled.
	sed -i -e 's:i\[3,4,5,6\]86:___:g' makefile || die "sed makefile failed"

	# Fix version number of shared library.
	sed -i -e 's/PLV="2"/PLV="3"/' tools/buildall.sh || die "sed tools/buildall.sh failed"

	# Respect LDFLAGS and fix soname and strip issues.
	epatch "${FILESDIR}/${PN}-3.3.2-ld.patch"

	# Use external zlib.
	epatch "${FILESDIR}/${PN}-3.3.2-external-zlib.patch"
}

src_compile() {
	local libname="libcl.so.${PV}"

	# At least -O2 is needed.
	replace-flags -O  -O2
	replace-flags -O0 -O2
	replace-flags -O1 -O2
	replace-flags -Os -O2
	is-flagq -O* || append-flags -O2

	append-flags "-D __UNIX__ -DOSVERSION=2 -DNDEBUG -I."

	if [ -f /usr/include/pthread.h -a \
	`grep -c PTHREAD_MUTEX_RECURSIVE /usr/include/pthread.h` -ge 0 ] ; then
		append-flags "-DHAS_RECURSIVE_MUTEX"
	fi
	if [ -f /usr/include/pthread.h -a \
	`grep -c PTHREAD_MUTEX_ROBUST /usr/include/pthread.h` -ge 0 ] ; then
		append-flags "-DHAS_ROBUST_MUTEX"
	fi

	use ldap && append-flags -DHAS_LDAP
	use odbc && append-flags -DHAS_ODBC

	emake directories || die
	emake toolscripts || die
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -c" Linux || die "emake static failed"

	emake TARGET=${libname} OBJPATH="./shared-obj/" CC="$(tc-getCC)" \
	CFLAGS="${CFLAGS} -fPIC -c" Linux || die "emake shared failed"

	if use python; then
		ln -s libcl.so.${PV} libcl.so || die

		# Python bindings don't work with -O2 and higher.
		replace-flags -O* -O1

		cd bindings
		distutils_src_compile
	fi
}

src_install() {
	dolib.so "libcl.so.${PV}" || die
	dosym "libcl.so.${PV}" "/usr/$(get_libdir)/libcl.so" || die
	dolib.a "libcl.a" || die

	insinto /usr/include
	doins cryptlib.h || die

	if use python; then
		pushd bindings > /dev/null
		distutils_src_install
		popd > /dev/null
	fi

	dodoc README || die
	if use doc; then
		newdoc "${DOC_PREFIX}-manual.pdf" "manual.pdf" || die
	fi
}
