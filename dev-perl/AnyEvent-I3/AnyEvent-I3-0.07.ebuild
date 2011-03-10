# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

MODULE_AUTHOR="MSTPLBG"
MODULE_VERSION="${PV}"

inherit perl-module

DESCRIPTION="Communicate with the i3 window manager"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/AnyEvent"
DEPEND=""
