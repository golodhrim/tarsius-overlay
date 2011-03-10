# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

: ${EGIT_REPO_URI:="git://github.com/cortesi/qtile.git"}
: ${EGIT_BRANCH:="master"}

inherit git distutils

DESCRIPTION="A small, flexible, scriptable tiling window manager written in Python"
HOMEPAGE="http://www.qtile.org"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pycairo
	dev-python/python-xlib
	x11-libs/cairo[xcb]
	x11-libs/libxcb"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	echo "exec ${PN}" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"
}
