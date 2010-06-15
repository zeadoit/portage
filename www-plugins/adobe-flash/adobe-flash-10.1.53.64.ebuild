# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/adobe-flash/adobe-flash-10.1.53.64.ebuild,v 1.3 2010/06/13 14:21:48 lack Exp $

EAPI=1
inherit nsplugins rpm multilib toolchain-funcs

MY_32B_URI="http://fpdownload.macromedia.com/get/flashplayer/current/flash-plugin-${PV}-release.i386.rpm"

DESCRIPTION="Adobe Flash Player"
SRC_URI="${MY_32B_URI}"
HOMEPAGE="http://www.adobe.com/"
IUSE="multilib"
SLOT="0"

KEYWORDS="-* ~x86"
LICENSE="AdobeFlash-10"
RESTRICT="strip mirror"

S="${WORKDIR}"

NATIVE_DEPS="x11-libs/gtk+:2
	media-libs/fontconfig
	dev-libs/nss
	net-misc/curl
	>=sys-libs/glibc-2.4"

EMUL_DEPS=">=app-emulation/emul-linux-x86-baselibs-20100409
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs"

RDEPEND="x86? ( $NATIVE_DEPS )
	amd64? ( $EMUL_DEPS
		www-plugins/nspluginwrapper )
	|| ( media-fonts/liberation-fonts media-fonts/corefonts )"

# Ignore QA warnings in these binary closed-source libraries, since we can't fix
# them:
QA_EXECSTACK="opt/netscape/plugins32/libflashplayer.so
	opt/netscape/plugins/libflashplayer.so"

QA_DT_HASH="opt/netscape/plugins32/libflashplayer.so
	opt/netscape/plugins/libflashplayer.so"

pkg_setup() {
	if use x86; then
		export native_install=1
	elif use amd64; then
		# As of 10.1, no more native 64b version *grumble grumble*
		unset native_install
		unset need_lahf_wrapper
		export amd64_32bit=1
	fi
}

src_compile() {
	if [[ $need_lahf_wrapper ]]; then
		# This experimental wrapper, from Maks Verver via bug #268336 should
		# emulate the missing lahf instruction affected platforms.
		$(tc-getCC) -fPIC -shared -nostdlib -lc -oflashplugin-lahf-fix.so \
			"${FILESDIR}/flashplugin-lahf-fix.c" \
			|| die "Compile of flashplugin-lahf-fix.so failed"
	fi
}

src_install() {
	if [[ $native_install ]]; then
		# 32b RPM has things hidden in funny places
		use x86 && pushd "${S}/usr/lib/flash-plugin"

		exeinto /opt/netscape/plugins
		doexe libflashplayer.so
		inst_plugin /opt/netscape/plugins/libflashplayer.so

		use x86 && popd

		# 64b tarball has no readme file.
		use x86 && dodoc "${S}/usr/share/doc/flash-plugin-${PV}/readme.txt"
	fi

	if [[ $need_lahf_wrapper ]]; then
		# This experimental wrapper, from Maks Verver via bug #268336 should
		# emulate the missing lahf instruction affected platforms.
		exeinto /opt/netscape/plugins
		doexe flashplugin-lahf-fix.so
		inst_plugin /opt/netscape/plugins/flashplugin-lahf-fix.so
	fi

	if [[ $amd64_32bit ]]; then
		oldabi="${ABI}"
		ABI="x86"

		# 32b plugin
		pushd "${S}/usr/lib/flash-plugin"
			exeinto /opt/netscape/plugins32/
			doexe libflashplayer.so
			inst_plugin /opt/netscape/plugins32/libflashplayer.so
			dodoc "${S}/usr/share/doc/flash-plugin-${PV}/readme.txt"
		popd

		ABI="${oldabi}"
	fi

	# The magic config file!
	insinto "/etc/adobe"
	doins "${FILESDIR}/mms.cfg"
}

pkg_postinst() {
	if use amd64; then
		elog "Adobe has released 10.1 in only a 32-bit version so far and"
		elog "upgrading is required to close a major security exploit[1]."
		elog "You will be going back to a 32-bit plugin with nswrapper until"
		elog "Adobe decides otherwise."
		elog "  [1] http://bugs.gentoo.org/322855"
		elog
		if has_version 'www-plugins/nspluginwrapper'; then
			if [[ $native_install ]]; then
				# TODO: Perhaps parse the output of 'nspluginwrapper -l'
				#       However, the 64b flash plugin makes 'nspluginwrapper -l' segfault.
				local FLASH_WRAPPER="${ROOT}/usr/lib64/nsbrowser/plugins/npwrapper.libflashplayer.so"
				if [[ -f ${FLASH_WRAPPER} ]]; then
					einfo "Removing duplicate 32-bit plugin wrapper: Native 64-bit plugin installed"
					nspluginwrapper -r "${FLASH_WRAPPER}"
				fi
				if [[ $need_lahf_wrapper ]]; then
					ewarn "Your processor does not support the 'lahf' instruction which is used"
					ewarn "by Adobe's 64-bit flash binary.  We have installed a wrapper which"
					ewarn "should allow this plugin to run.  If you encounter problems, please"
					ewarn "adjust your USE flags to install only the 32-bit version and reinstall:"
					ewarn "  ${CATEGORY}/$PN[+32bit -64bit]"
				fi
			else
				oldabi="${ABI}"
				ABI="x86"
				local FLASH_SOURCE="${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/libflashplayer.so"

				einfo "nspluginwrapper detected: Installing plugin wrapper"
				nspluginwrapper -i "${FLASH_SOURCE}"

				ABI="${oldabi}"
			fi
		elif [[ ! $native_install ]]; then
			einfo "To use the 32-bit flash player in a native 64-bit firefox,"
			einfo "you must install www-plugins/nspluginwrapper"
		fi
	fi

	ewarn "Flash player is closed-source, with a long history of security"
	ewarn "issues.  Please consider only running flash applets you know to"
	ewarn "be safe.  The 'flashblock' extension may help for mozilla users:"
	ewarn "  https://addons.mozilla.org/en-US/firefox/addon/433"
}