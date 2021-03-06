# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-rtkit/selinux-rtkit-2.20120215.ebuild,v 1.3 2012/05/31 08:20:41 swift Exp $
EAPI="4"

IUSE=""
MODS="rtkit"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for rtkit"

KEYWORDS="amd64 x86"
DEPEND=">=sec-policy/selinux-dbus-2.20120215"
RDEPEND="${DEPEND}"
