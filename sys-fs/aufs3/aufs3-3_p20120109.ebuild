# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs3/aufs3-3_p20120109.ebuild,v 1.4 2012/05/24 02:55:43 vapier Exp $

EAPI=4

inherit linux-mod multilib toolchain-funcs eutils

AUFS_VERSION="${PV%%_p*}"
PATCH_MAX_VER="2"
UTIL_MAX_VER="0"

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc fuse pax_kernel hfs inotify kernel-patch nfs ramfs"

DEPEND="dev-vcs/git"
RDEPEND="
	!sys-fs/aufs
	!sys-fs/aufs2"

S="${WORKDIR}"/${PN}-standalone

MODULE_NAMES="aufs(misc:${S})"

pkg_setup() {
	CONFIG_CHECK="${CONFIG_CHECK} ~EXPERIMENTAL"
	use inotify && CONFIG_CHECK="${CONFIG_CHECK} ~FSNOTIFY"
	use nfs && CONFIG_CHECK="${CONFIG_CHECK} EXPORTFS"
	use fuse && CONFIG_CHECK="${CONFIG_CHECK} ~FUSE_FS"
	use hfs && CONFIG_CHECK="${CONFIG_CHECK} ~HFSPLUS_FS"

	# this is needed so merging a binpkg ${PN} is possible w/out a kernel unpacked on the system
	[ -n "$PKG_SETUP_HAS_BEEN_RAN" ] && return

	get_version
	kernel_is lt 3 0 0 && die "kernel too old, Please use sys-fs/aufs2"
	kernel_is gt 3 2 99 && die "kernel too new"

	linux-mod_pkg_setup

	if [[ "${KV_MINOR}" -gt "${PATCH_MAX_VER}" ]]; then
		PATCH_BRANCH="x-rcN"
	else
		PATCH_BRANCH="${KV_MINOR}"
	fi

	if [[ "${PATCH_BRANCH}" == "x-rcN" ]]; then
		UTIL_BRANCH="x-rcN"
	elif [[ "${KV_MINOR}" -gt "${UTIL_MAX_VER}" ]]; then
		UTIL_BRANCH="${UTIL_MAX_VER}"
	else
		UTIL_BRANCH="${KV_MINOR}"
	fi

	if ! ( patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/${PN}-standalone-${PATCH_BRANCH}.patch >/dev/null && \
		patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/${PN}-base-${PATCH_BRANCH}.patch >/dev/null ); then
		if use kernel-patch; then
			cd ${KV_DIR}
			ewarn "Patching your kernel..."
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/${PN}-standalone-${PATCH_BRANCH}.patch >/dev/null
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/${PN}-base-${PATCH_BRANCH}.patch >/dev/null
			epatch "${FILESDIR}"/${PN}-{base,standalone}-${PATCH_BRANCH}.patch
			[[ ${KV_MINOR} -gt ${PATCH_MAX_VER} ]] && \
				epatch "${FILESDIR}"/${PN}-fix-export-__devcgroup_inode_permission.patch
			ewarn "You need to compile your kernel with the applied patch"
			ewarn "to be able to load and use the aufs kernel module"
		else
			eerror "You need to apply a patch to your kernel to compile and run the ${PN} module"
			eerror "Either enable the kernel-patch useflag to do it with this ebuild"
			eerror "or apply ${FILESDIR}/${PN}-base-${PATCH_BRANCH}.patch and"
			eerror "${FILESDIR}/${PN}-standalone-${PATCH_BRANCH}.patch by hand"
			die "missing kernel patch, please apply it first"
		fi
	fi
	export PKG_SETUP_HAS_BEEN_RAN=1
}

set_config() {
	for option in $*; do
		grep -q "^CONFIG_AUFS_${option} =" config.mk || die "${option} is not a valid config option"
		sed "/^CONFIG_AUFS_${option}/s:=:= y:g" -i config.mk || die
	done
}

src_prepare() {
	local module_branch=origin/${PN}.${PATCH_BRANCH}
	local util_branch=origin/${PN}.${UTIL_BRANCH}

	einfo "Using for module creation branch ${module_branch}"
	git checkout -q -b local-gentoo ${module_branch} || die

	# All config options to off
	sed "s:= y:=:g" -i config.mk || die

	set_config RDU BRANCH_MAX_127 SBILIST

	use debug && set_config DEBUG
	use fuse && set_config BR_FUSE POLL
	use hfs && set_config BR_HFSPLUS
	use inotify && set_config HNOTIFY HFSNOTIFY
	use nfs && set_config EXPORT
	use nfs && use amd64 && set_config INO_T_64
	use ramfs && set_config BR_RAMFS

	use pax_kernel && epatch "${FILESDIR}"/pax.patch

	sed -i "s:aufs.ko usr/include/linux/aufs_type.h:aufs.ko:g" Makefile || die
	sed -i "s:__user::g" include/linux/aufs_type.h || die

	cd "${WORKDIR}"/${PN/3}-util

	einfo "Using for utils building branch ${util_branch}"
	git checkout -b local-gentoo ${util_branch} || die
	sed -i "/LDFLAGS += -static -s/d" Makefile || die
	sed -i -e "s:m 644 -s:m 644:g" -e "s:/usr/lib:/usr/$(get_libdir):g" libau/Makefile || die
}

src_compile() {
	local ARCH=x86

	emake CC=$(tc-getCC) CONFIG_AUFS_FS=m KDIR=${KV_DIR}

	cd "${WORKDIR}"/${PN/3}-util
	emake CC=$(tc-getCC) AR=$(tc-getAR) KDIR=${KV_DIR} C_INCLUDE_PATH="${S}"/include
}

src_install() {
	linux-mod_src_install

	insinto /usr/share/doc/${PF}

	use doc && doins -r Documentation

	dodoc README

	cd "${WORKDIR}"/${PN/3}-util
	emake DESTDIR="${D}" KDIR=${KV_DIR} install

	newdoc README README-utils
}
