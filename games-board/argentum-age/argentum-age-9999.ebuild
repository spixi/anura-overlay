# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop

ANURA_PATH="/usr/lib/anura"
MY_PV="trunk"
HOMEPAGE="http://argentumage.com/"
SRC_URI="https://github.com/davewx7/citadel/archive/master.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=games-engines/anura-9999"
DEPEND="${RDEPEND}
media-gfx/imagemagick[png]"

src_unpack() {
	unpack ${A}
	mv citadel-master ${P}
	cd ${P}
	convert aa-icon.ico argentum-age.png
}

src_install() {
	doicon argentum-age.png
	domenu "${FILESDIR}/argentum-age.desktop"
	dodoc README.md readme.txt
	insinto "${ANURA_PATH}/modules/citadel"
	doins -r data images music sounds module.cfg master-config.cfg CONTRIBUTING LICENSE
}
