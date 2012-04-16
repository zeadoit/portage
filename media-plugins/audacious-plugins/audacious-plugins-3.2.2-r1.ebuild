# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-plugins/audacious-plugins-3.2.2-r1.ebuild,v 1.1 2012/04/16 00:37:55 jdhore Exp $

EAPI=4

inherit eutils autotools flag-o-matic

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="aac adplug alsa bs2b cdda cue ffmpeg flac fluidsynth gnome +gtk gtk3 ipv6 jack
lame libnotify libsamplerate midi mms mp3 mtp nls oss pulseaudio scrobbler sid sndfile vorbis wavpack"

RDEPEND="app-arch/unzip
	>=dev-libs/dbus-glib-0.60
	dev-libs/libxml2:2
	media-libs/libmodplug
	>=media-sound/audacious-3.2.2-r1
	>=net-libs/neon-0.26.4
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	aac? ( >=media-libs/faad2-2.7 )
	adplug? ( >=dev-cpp/libbinio-1.4 )
	alsa? ( >=media-libs/alsa-lib-1.0.16 )
	bs2b? ( media-libs/libbs2b )
	cdda? ( >=media-libs/libcddb-1.2.1
		>=dev-libs/libcdio-0.79-r1 )
	cue? ( media-libs/libcue )
	ffmpeg? ( >=media-video/ffmpeg-0.7.3
		  !media-video/libav )
	flac? ( >=media-libs/libvorbis-1.0
		>=media-libs/flac-1.2.1-r1 )
	fluidsynth? ( media-sound/fluidsynth )
	jack? ( >=media-libs/bio2jack-0.4
		media-sound/jack-audio-connection-kit )
	lame? ( media-sound/lame )
	libnotify? ( x11-libs/libnotify )
	libsamplerate? ( media-libs/libsamplerate )
	mms? ( >=media-libs/libmms-0.3 )
	mp3? ( >=media-sound/mpg123-1.12.1 )
	mtp? ( media-libs/libmtp )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.3 )
	scrobbler? ( net-misc/curl )
	sid? ( >=media-libs/libsidplay-2.1.1-r2 )
	sndfile? ( >=media-libs/libsndfile-1.0.17-r1 )
	vorbis? ( >=media-libs/libvorbis-1.2.0
		  >=media-libs/libogg-1.1.3 )
	wavpack? ( >=media-sound/wavpack-4.50.1-r1 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0"

REQUIRED_USE="^^ ( gtk gtk3 )"

DOCS="AUTHORS"

mp3_warning() {
	if ! use mp3 ; then
		ewarn "MP3 support is optional, you may want to enable the mp3 USE-flag"
	fi
}

src_prepare() {
	epatch "$FILESDIR"/${P}-fix-build-gmodule.patch
	eaclocal -I m4
	eautoheader
	eautoconf
}

src_configure() {
	mp3_warning

	econf \
		--enable-modplug \
		--enable-neon \
		$(use_enable adplug) \
		$(use_enable aac) \
		$(use_enable alsa) \
		$(use_enable alsa amidiplug-alsa) \
		$(use_enable bs2b) \
		$(use_enable cdda cdaudio) \
		$(use_enable cue) \
		$(use_enable ffmpeg ffaudio) \
		$(use_enable flac flacng) \
		$(use_enable fluidsynth amidiplug-flsyn) \
		$(use_enable flac filewriter_flac) \
		$(use_enable gtk3) \
		$(use_enable ipv6) \
		$(use_enable jack) \
		$(use_enable gnome gnomeshortcuts) \
		$(use_enable lame filewriter_mp3) \
		$(use_enable libnotify notify) \
		$(use_enable libsamplerate resample) \
		$(use_enable mms) \
		$(use_enable mp3) \
		$(use_enable midi amidiplug) \
		$(use_enable mtp mtp_up) \
		$(use_enable nls) \
		$(use_enable oss) \
		$(use_enable pulseaudio pulse) \
		$(use_enable scrobbler) \
		$(use_enable sid) \
		$(use_enable sndfile) \
		$(use_enable vorbis) \
		$(use_enable vorbis filewriter_vorbis) \
		$(use_enable wavpack)
}
