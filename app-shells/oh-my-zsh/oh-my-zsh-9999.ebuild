# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit git

: ${GITHUB_USER:="robbyrussell"}
: ${GITHUB_REPO:="oh-my-zsh"}
: ${EGIT_REPO_URI:=""}

DESCRIPTION="Functions and auto-complete helpers for zsh"
HOMEPAGE="https://github.com/${GITHUB_USER}/${GITHUB_REPO}"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#DEPEND=""
RDEPEND="app-shells/zsh"
