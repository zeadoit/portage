# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.2.1-r1.ebuild,v 1.1 2010/07/03 14:17:46 mabi Exp $

EAPI="2"

inherit eutils webapp depend.php

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
mirror://gentoo/${P}-git20100511.patch.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	virtual/httpd-php
	virtual/httpd-cgi
	|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
	>=dev-php5/ezc-Base-1.8
	>=dev-php5/ezc-Graph-1.5
	>=dev-php/adodb-5.10"

src_prepare() {
	epatch "${WORKDIR}/${P}-git20100511.patch"
	# Drop external libraries
	rm -r "${S}/library/adodb/"
	rm -r "${S}/library/ezc/"{Base,Graph}
	sed -e 's:ezc/Base/src/base.php:ezc/Base/base.php:' \
		-i "${S}"/plugins/MantisGraph/{core/graph_api.php,pages/summary_graph_cumulative_bydate2.php} \
			|| die
	# Fix incorrect filename
	sed -e 's:config_default_inc.php:config_defaults_inc.php:' \
		-i "${S}/lang/strings_russian.txt" || die
}

src_install() {
	webapp_src_preinst
	rm doc/{LICENSE,INSTALL}
	dodoc doc/{CREDITS,CUSTOMIZATION,RELEASE} doc/en/*

	rm -rf doc packages
	mv config_inc.php.sample config_inc.php
	cp -R . "${D}/${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}/config_inc.php"
	webapp_postinst_txt en "${FILESDIR}/postinstall-en-1.0.0.txt"
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	elog "Note, that this branch of mantisbt does not work with PostgreSQL."
	elog "If really need mantisbt to work with PostgreSQL you'll have to"
	elog "install it manually from upstream svn repository:"
	elog "https://sourceforge.net/svn/?group_id=14963"
}
