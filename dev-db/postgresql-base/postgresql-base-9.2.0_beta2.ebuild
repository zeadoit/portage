# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-base/postgresql-base-9.2.0_beta2.ebuild,v 1.1 2012/06/06 14:02:33 titanofold Exp $

EAPI="4"

WANT_AUTOMAKE="none"

inherit autotools eutils flag-o-matic multilib prefix versionator

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x86-solaris"

SLOT="$(get_version_component_range 1-2)"

# Comment the following five lines when not a beta or rc.
MY_PV="${PV//_}"
MY_FILE_PV="${SLOT}$(get_version_component_range 4)"
S="${WORKDIR}/postgresql-${MY_FILE_PV}"
SRC_URI="mirror://postgresql/source/v${MY_PV}/postgresql-${MY_FILE_PV}.tar.bz2
		 http://dev.gentoo.org/~titanofold/postgresql-patches-${MY_FILE_PV}.tbz2"

# Comment the following three lines when a beta or rc.
#S="${WORKDIR}/postgresql-${PV}"
#SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2
#		 http://dev.gentoo.org/~titanofold/postgresql-patches-${PV}.tbz2"

LICENSE="POSTGRESQL"
DESCRIPTION="PostgreSQL libraries and clients"
HOMEPAGE="http://www.postgresql.org/"

# No tests to be done for clients and libraries
RESTRICT="test"

LINGUAS="af cs de en es fa fr hr hu it ko nb pl pt_BR ro ru sk sl sv tr zh_CN zh_TW"
IUSE="doc kerberos ldap nls pam pg_legacytimestamp readline ssl threads zlib"

for lingua in ${LINGUAS} ; do
	IUSE+=" linguas_${lingua}"
done

wanted_languages() {
	local enable_langs

	for lingua in ${LINGUAS} ; do
		use linguas_${lingua} && enable_langs+="${lingua} "
	done

	echo -n ${enable_langs}
}

RDEPEND="!!dev-db/libpq
		 !!dev-db/postgresql
		 !!dev-db/postgresql-client
		 !!dev-db/postgresql-libs
		 sys-apps/less
		 >=app-admin/eselect-postgresql-1.0.10
		 virtual/libintl
		 kerberos? ( virtual/krb5 )
		 ldap? ( net-nds/openldap )
		 pam? ( virtual/pam )
		 readline? ( sys-libs/readline )
		 ssl? ( >=dev-libs/openssl-0.9.6-r1 )
		 zlib? ( sys-libs/zlib )
"

DEPEND="${RDEPEND}
		!!<sys-apps/sandbox-2.0
		sys-devel/bison
		sys-devel/flex
		nls? ( sys-devel/gettext )
"

PDEPEND="doc? ( ~dev-db/postgresql-docs-${PV} )"

# Support /var/run or /run for the socket directory
[[ ! -d /run ]] && RUNDIR=/var

src_prepare() {
	epatch "${WORKDIR}/autoconf.patch" \
		"${WORKDIR}/base.patch" \
		"${WORKDIR}/bool.patch"

	eprefixify src/include/pg_config_manual.h

	# to avoid collision - it only should be installed by server
	rm "${S}/src/backend/nls.mk"

	# because psql/help.c includes the file
	ln -s "${S}/src/include/libpq/pqsignal.h" "${S}/src/bin/psql/" || die

	sed -e "s|@RUNDIR@|${RUNDIR}|g" \
		-i src/include/pg_config_manual.h || \
		die "RUNDIR sed failed"

	eautoconf
}

src_configure() {
	case ${CHOST} in
		*-darwin*|*-solaris*)
			use nls && append-libs intl
			;;
	esac

	export LDFLAGS_SL="${LDFLAGS}"
	export LDFLAGS_EX="${LDFLAGS}"

	local PO="${EPREFIX%/}"

	econf \
		--prefix="${PO}/usr/$(get_libdir)/postgresql-${SLOT}" \
		--datadir="${PO}/usr/share/postgresql-${SLOT}" \
		--docdir="${PO}/usr/share/doc/postgresql-${SLOT}" \
		--sysconfdir="${PO}/etc/postgresql-${SLOT}" \
		--includedir="${PO}/usr/include/postgresql-${SLOT}" \
		--mandir="${PO}/usr/share/postgresql-${SLOT}/man" \
		--without-tcl \
		--without-perl \
		--without-python \
		$(use_with readline) \
		$(use_with kerberos krb5) \
		$(use_with kerberos gssapi) \
		"$(use_enable nls nls "$(wanted_languages)")" \
		$(use_with pam) \
		$(use_enable !pg_legacytimestamp integer-datetimes) \
		$(use_with ssl openssl) \
		$(use_enable threads thread-safety) \
		$(use_with zlib) \
		$(use_with ldap)
}

src_compile() {
	emake

	cd "${S}/contrib"
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/include/postgresql-${SLOT}/postmaster
	doins "${S}"/src/include/postmaster/*.h

	dodir /usr/share/postgresql-${SLOT}/man/
	cp -r "${S}"/doc/src/sgml/man{1,7} "${ED}"/usr/share/postgresql-${SLOT}/man/ || die
	rm "${ED}/usr/share/postgresql-${SLOT}/man/man1"/{initdb,pg_{controldata,ctl,resetxlog},post{gres,master}}.1
	docompress /usr/share/postgresql-${SLOT}/man/man{1,7}
	dodoc README HISTORY doc/{TODO,bug.template}

	cd "${S}/contrib"
	emake DESTDIR="${D}" install
	cd "${S}"

	dodir /etc/eselect/postgresql/slots/${SLOT}
	echo "postgres_ebuilds=\"\${postgres_ebuilds} ${PF}\"" > \
		"${ED}/etc/eselect/postgresql/slots/${SLOT}/base"

	keepdir /etc/postgresql-${SLOT}
}

pkg_postinst() {
	postgresql-config update

	elog "If you need a global psqlrc-file, you can place it in:"
	elog "    ${EROOT%/}/etc/postgresql-${SLOT}/"
}

pkg_postrm() {
	postgresql-config update
}
