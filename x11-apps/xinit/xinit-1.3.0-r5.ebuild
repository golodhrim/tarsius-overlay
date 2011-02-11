# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit xorg-2

DESCRIPTION="X Window System initializer"

LICENSE="${LICENSE} GPL-2"
KEYWORDS=""
IUSE="+minimal"

RDEPEND="
	!<x11-base/xorg-server-1.8.0
	x11-apps/xauth
	x11-libs/libX11"
DEPEND="${RDEPEND}"
PDEPEND="
	x11-apps/xmessage
	x11-apps/xrdb
	!minimal? (
		x11-apps/xsm
		x11-terms/xterm
	)"

PATCHES=(
	"${FILESDIR}/funtoo/0001-Gentoo-customizations.patch"
)

pkg_setup() {
	xorg-2_pkg_setup

	CONFIGURE_OPTIONS="--with-xinitdir=/etc/X11/xinit"
}

src_install() {
	xorg-2_src_install

	exeinto /etc/X11
	doexe "${FILESDIR}"/funtoo/chooser.sh "${FILESDIR}"/funtoo/startDM.sh || die
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/funtoo/Xsession || die
	exeinto /etc/X11/xinit
	doexe "${FILESDIR}"/funtoo/xserverrc || die
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}"/funtoo/00-xhost
}

pkg_postinst() {
	xorg-2_pkg_postinst

	ewarn "If you use startx to start X instead of a login manager like gdm/kdm,"
	ewarn "you can set the XSESSION variable to anything in /etc/X11/Sessions/ or"
	ewarn "any executable. When you run startx, it will run this as the login session."
	ewarn "You can set this in a file in /etc/env.d/ for the entire system,"
	ewarn "or set it per-user in ~/.bash_profile (or similar for other shells)."
	ewarn "Here's an example of setting it for the whole system:"
	ewarn "    echo XSESSION=\"Gnome\" > /etc/env.d/90xsession"
	ewarn "    env-update && source /etc/profile"
}
