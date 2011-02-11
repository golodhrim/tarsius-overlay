# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit xorg-2

DESCRIPTION="X Window System initializer"

LICENSE="${LICENSE} GPL-2"
KEYWORDS="~amd64 ~x86"
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

CONFIGURE_OPTIONS="--with-xinitdir=/etc/X11/xinit"

src_install() {
	xorg-2_src_install

	exeinto /usr/bin
	doexe "${FILESDIR}"/funtoo/startx || die
	exeinto /etc/X11
	doexe "${FILESDIR}"/funtoo/{chooser,startDM}.sh || die
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/funtoo/Xsession || die
	exeinto /etc/X11/xinit
	doexe "${FILESDIR}"/funtoo/x{init,server}rc || die
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}"/funtoo/00-xhost
}

pkg_postinst() {
	einfo "If you use startx to start X instead of a login manager like gdm/kdm,"
	einfo "you can set the XSESSION variable to anything in /etc/X11/Sessions/ or"
	einfo "any executable. When you run startx, it will run this as the login session."
	einfo "You can set this in a file in /etc/env.d/ for the entire system,"
	einfo "or set it per-user in ~/.bash_profile (or similar for other shells)."
	einfo "Here's an example of setting it for the whole system:"
	einfo "    echo XSESSION=\"Gnome\" > /etc/env.d/90xsession"
	einfo "    env-update && source /etc/profile"
}
