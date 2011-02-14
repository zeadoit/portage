# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/gallery/gallery-2.3-r2.ebuild,v 1.3 2011/02/13 18:42:59 armin76 Exp $

EAPI="2"

inherit webapp eutils depend.php confutils

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="ffmpeg gd imagemagick mysql netpbm postgres raw sqlite unzip zip"

RDEPEND="raw? ( >=media-gfx/dcraw-8.03 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20051216 )
	imagemagick? ( >media-gfx/imagemagick-6.2.4 )
	netpbm? ( >=media-libs/netpbm-9.12 >=media-gfx/jhead-2.2 )
	unzip? ( app-arch/unzip )
	zip? ( app-arch/zip )
	sqlite? ( dev-lang/php[pdo] )
	gd? ( || ( dev-lang/php[gd] dev-lang/php[gd-external] ) )
	dev-lang/php[mysql?,session,postgres?]
	|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"

S=${WORKDIR}/${PN}2

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	confutils_require_any gd imagemagick netpbm
	confutils_require_any mysql postgres sqlite
}

src_install() {
	webapp_src_preinst

	dohtml README.html
	rm README.html LICENSE
	sed -i -e "/^LICENSE\>/d" -e "/^README\.html\>/d" MANIFEST

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_postinst_txt en "${FILESDIR}/postinstall-en2.txt"
	webapp_src_install
}

pkg_postinst() {
	elog "You are strongly encouraged to back up your database"
	elog "and the g2data directory, as upgrading to 2.2 will make"
	elog "irreversible changes to both."
	elog
	elog "g2data dir: cp -Rf /path/to/g2data/ /path/to/backup"
	elog "mysql: mysqldump --opt -u username -h hostname -p database > /path/to/backup.sql"
	elog "postgres: pg_dump -h hostname --format=t database > /path/to/backup.sql"
	webapp_pkg_postinst
}
