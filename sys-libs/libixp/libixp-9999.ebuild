# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# from devnull overlay but modified

EAPI="2"

inherit toolchain-funcs mercurial

DESCRIPTION="Standalone client/server 9P library"
HOMEPAGE="http://libs.suckless.org/libixp"
EHG_REPO_URI="http://hg.suckless.org/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e "/^ *PREFIX/s|=.*|= /usr|" \
		-e "/^ *ETC/s|=.*|= /etc|" \
		-e "/^ *CFLAGS/s|=|+=|" \
		-e "/^ *LDFLAGS/s|=|+=|" \
		"${S}"/config.mk || die "sed failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
}
