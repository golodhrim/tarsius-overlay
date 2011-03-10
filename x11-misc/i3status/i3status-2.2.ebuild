# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

DESCRIPTION="Generate a status bar for menuing programs"
HOMEPAGE="http://i3.zekjur.net/${PN}/"
SRC_URI="http://i3.zekjur.net/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/confuse
	net-wireless/wireless-tools"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	doman man/${PN}.1 || die "doman failed"
}
