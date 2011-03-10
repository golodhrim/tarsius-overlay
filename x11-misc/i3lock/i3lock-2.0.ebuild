# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

DESCRIPTION="A simple screen locker"
HOMEPAGE="http://i3.zekjur.net/${PN}/"
SRC_URI="http://i3.zekjur.net/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	sys-libs/pam
	x11-libs/cairo
	x11-libs/libxcb"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README
}
