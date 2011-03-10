# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3
inherit eutils git

DESCRIPTION="Windows Manager From Scratch"
HOMEPAGE="https://www.wmfs.info"
EGIT_REPO_URI="git://git.wmfs.info/wmfs.git"
EGIT_PROJECT="wmfs"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama xrandr imlib2"

DEPEND="
	>=media-libs/freetype-2
	x11-libs/libX11
	x11-libs/libXft
	imlib2? ( media-libs/imlib2 )
	xinerama? ( x11-libs/libXinerama )
	xrandr? ( x11-libs/libXrandr )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	# can't use econf, breaks on unknown args
	./configure \
		--prefix "/usr" \
		--man-prefix "/usr/share/man" \
		--xdg-config-dir "/etc/xdg" \
		$(use_with imlib2) \
		$(use_with xinerama) \
		$(use_with xrandr)
}

src_install() {
	emake DESTDIR="${D}" install || die

	echo "${PN}" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}" || die
}
