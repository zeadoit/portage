# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jmx/jmx-1.0-r3.ebuild,v 1.5 2012/06/07 21:25:03 ranger Exp $

EAPI=4

inherit java-virtuals-2

DESCRIPTION="Virtual for Java Management Extensions (JMX)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="|| (
			virtual/jre:1.7
			virtual/jre:1.6
			virtual/jre:1.5
			dev-java/sun-jmx:0
		)
		>=dev-java/java-config-2.1.8
		"

JAVA_VIRTUAL_PROVIDES="sun-jmx"
JAVA_VIRTUAL_VM="=virtual/jre-1.7 =virtual/jre-1.6 =virtual/jre-1.5"
