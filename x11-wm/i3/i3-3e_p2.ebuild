# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit versionator multilib

MY_PV="$(get_major_version).$(get_version_component_range 2)-bf2"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An improved dynamic tiling window manager"
HOMEPAGE="http://i3.zekjur.net"
SRC_URI="http://i3.zekjur.net/downloads/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc wsbar"

RDEPEND="
	dev-libs/libev
	dev-libs/yajl
	x11-libs/libX11
	>=x11-libs/libxcb-1.1.93
	>=x11-libs/xcb-util-0.3.3
	wsbar? (
		>=dev-lang/perl-5.10
		dev-perl/AnyEvent-I3
		dev-perl/IPC-Run
		dev-perl/JSON-XS )"
DEPEND="${RDEPEND}
	>=app-text/asciidoc-8.3
	app-text/xmlto
	app-text/docbook-xml-dtd
	sys-devel/bison
	sys-devel/flex
	>=x11-proto/xcb-proto-1.3"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i \
		-e "s|/usr/local/include|/usr/include|" \
		-e "s|/usr/local/lib|/usr/$(get_libdir)|" \
		common.mk || die "sed failed"

	use wsbar || { sed -i -e "/i3-wsbar/d"      Makefile || die "sed failed" ; }
	use debug || { sed -i -e "/^DEBUG=/s|1|0|" common.mk || die "sed failed" ; }
}

src_compile() {
	emake || die "emake compile failed"

	emake -C man || die "emake man failed"

	use doc && { emake -C docs || die "emake docs failed" ; }
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	use wsbar || rm man/i3-wsbar.1
	doman man/*.1 || die "doman failed"

	dodoc GOALS TODO || die "dodoc failed"
	use doc && { dohtml -r docs/*.html || die "dohtml failed" ; }

	echo "exec ${PN}" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"
}
