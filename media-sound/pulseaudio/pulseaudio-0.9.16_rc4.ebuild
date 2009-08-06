# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pulseaudio/pulseaudio-0.9.16_rc4.ebuild,v 1.1 2009/08/05 13:52:21 flameeyes Exp $

EAPI=2

WANT_AUTOMAKE=1.11

inherit eutils libtool flag-o-matic autotools

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="http://www.pulseaudio.org/"
if [[ ${PV/_rc/} == ${PV} ]]; then
	SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"
else
	SRC_URI="http://0pointer.de/public/${P/_rc/-test}.tar.gz"
fi

S="${WORKDIR}/${P/_rc/-test}"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="alsa avahi caps jack lirc oss tcpd X hal dbus libsamplerate gnome bluetooth policykit asyncns +glib test doc udev"

RDEPEND="X? ( x11-libs/libX11 x11-libs/libSM x11-libs/libICE x11-libs/libXtst )
	caps? ( sys-libs/libcap )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.1-r1 )
	alsa? ( >=media-libs/alsa-lib-1.0.19 )
	glib? ( >=dev-libs/glib-2.4.0 )
	avahi? ( >=net-dns/avahi-0.6.12[dbus] )
	>=dev-libs/liboil-0.3.0
	jack? ( >=media-sound/jack-audio-connection-kit-0.100 )
	tcpd? ( sys-apps/tcp-wrappers )
	lirc? ( app-misc/lirc )
	dbus? ( >=sys-apps/dbus-1.0.0 )
	gnome? ( >=gnome-base/gconf-2.4.0 )
	hal? (
		>=sys-apps/hal-0.5.7
		>=sys-apps/dbus-1.0.0
	)
	app-admin/eselect-esd
	bluetooth? (
		|| ( >=net-wireless/bluez-4
			 >=net-wireless/bluez-libs-3 )
		>=sys-apps/dbus-1.0.0
	)
	policykit? ( sys-auth/policykit )
	asyncns? ( net-libs/libasyncns )
	udev? ( >=sys-fs/udev-143 )
	>=media-libs/audiofile-0.2.6-r1
	>=media-libs/speex-1.2_beta
	>=media-libs/libsndfile-1.0.10
	>=dev-libs/liboil-0.3.6
	sys-libs/gdbm
	>=sys-devel/libtool-2.2.4" # it's a valid RDEPEND, libltdl.so is used

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	X? ( x11-proto/xproto )
	dev-libs/libatomic_ops
	dev-util/pkgconfig
	dev-util/intltool"

RDEPEND="${RDEPEND}
	gnome-extra/gnome-audio"

pkg_setup() {
	enewgroup audio 18 # Just make sure it exists
	enewgroup realtime
	enewgroup pulse-access
	enewgroup pulse
	enewuser pulse -1 -1 /var/run/pulse pulse,audio

	if use udev && use hal; then
		elog "Please note that enabling both udev and hal will build both"
		elog "discover modules, but only udev will be ued automatically."
		elog "If you wish to use hal you have to enable it explicitly"
		elog "or you might just disable the hal USE flag entirely."
	fi
}

src_prepare() {
	# Not extremely nice but allows to avoid a bit of work in the case
	# users don't request tests.
	if use test; then
		sed -i -e 's:\<mix-test::' src/Makefile.am || die

		eautomake
	fi
	elibtoolize
}

src_configure() {
	# To properly fix CVE-2008-0008
	append-flags -UNDEBUG

	# It's a binutils bug, once I can find time to fix that I'll add a
	# proper dependency and fix this up. — flameeyes
	append-ldflags -Wl,--no-as-needed

	econf \
		--enable-largefile \
		$(use_enable glib glib2) \
		--disable-solaris \
		$(use_enable asyncns) \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable lirc) \
		$(use_enable tcpd tcpwrap) \
		$(use_enable jack) \
		$(use_enable lirc) \
		$(use_enable avahi) \
		$(use_enable hal) \
		$(use_enable dbus) \
		$(use_enable gnome gconf) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable bluetooth bluez) \
		$(use_enable policykit polkit) \
		$(use_enable X x11) \
		$(use_enable test default-build-tests) \
		$(use_enable udev) \
		$(use_with caps) \
		--localstatedir=/var \
		--with-realtime-group=realtime \
		--disable-per-user-esound-socket \
		|| die "econf failed"

	if use doc; then
		pushd doxygen
		doxygen doxygen.conf || die
		popd
	fi
}

src_test() {
	# We avoid running the toplevel check target because that will run
	# po/'s tests too, and they are broken. Officially, it should work
	# with intltool 0.40.6, but that doesn't seem to be the case.
	emake -C src check || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	use avahi && sed -i -e '/module-zeroconf-publish/s:^#::' "${D}/etc/pulse/default.pa"

	if use hal && !use udev; then
		sed -i -e 's:-udev:-hal:' "${D}/etc/pulse/default.pa" || die
	fi

	dodoc README ChangeLog todo || die

	if use doc; then
		pushd doxygen/html
		dohtml * || die
		popd
	fi

	# Create the state directory
	diropts -o pulse -g pulse -m0755
	keepdir /var/run/pulse

	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	elog "If you want to make use of realtime capabilities of PulseAudio"
	elog "you should follow the realtime guide to create and set up a realtime"
	elog "user group: http://www.gentoo.org/proj/en/desktop/sound/realtime.xml"
	elog "Make sure you also have baselayout installed with pam USE flag"
	elog "enabled, if you're using the rlimit method."
	if use bluetooth; then
		elog
		elog "The BlueTooth proximity module is not enabled in the default"
		elog "configuration file. If you do enable it, you'll have to have"
		elog "your BlueTooth controller enabled and inserted at bootup or"
		elog "PulseAudio will refuse to start."
		elog
		elog "Please note that the BlueTooth proximity module seems itself"
		elog "still experimental, so please report to upstream if you have"
		elog "problems with it."
	fi
	if use alsa; then
		local pkg="media-plugins/alsa-plugins"
		if has_version ${pkg} && ! built_with_use --missing false ${pkg} pulseaudio; then
			elog
			elog "You have alsa support enabled so you probably want to install"
			elog "${pkg} with pulseaudio support to have"
			elog "alsa using applications route their sound through pulseaudio"
		fi
	fi

	eselect esd update --if-unset
}