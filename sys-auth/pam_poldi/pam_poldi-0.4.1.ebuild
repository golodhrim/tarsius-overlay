# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit pam

DESCRIPTION="Poldi is a PAM module implementing authentication via OpenPGP smartcards"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/poldi/poldi-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="usb"
DEPEND="dev-libs/libgcrypt
	virtual/pam
	>=dev-libs/libgpg-error-0.7
	usb? ( >=dev-libs/libusb-0.1.10a sys-apps/hotplug )"

RDEPEND=${DEPEND}

src_install() {
	einstall || die "einstall failed"
	dopammod ${S}/src/pam/pam_poldi.so
	#ChangeLog and INSTALL are not usefull
	dodoc AUTHORS COPYING NEWS README THANKS
	dodir /etc/poldi
	cp ${FILESDIR}/poldi.conf.example ${D}/etc/poldi
}
