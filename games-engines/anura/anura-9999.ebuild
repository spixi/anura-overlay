# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ANURA_PATH="/usr/lib/anura"
MY_PV="trunk"
DESCRIPTION="Anura is a fully-featured game engine, free for commercial and non-commercial use"
HOMEPAGE="https://github.com/anura-engine/anura"
SRC_URI="https://github.com/anura-engine/anura/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/anura-engine/imgui/archive/d7ce9212f1d321a1470c8ab8dceeed222c55a3ce.tar.gz -> imgui.tar.gz"

LICENSE="ZLIB MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/boost-1.50.0
	!>dev-libs/boost-1.67.0
	media-libs/libsdl2
	>=media-libs/sdl2-image-2.0.0[png]
	>=media-libs/sdl2-mixer-2.0.0[vorbis]
	>=media-libs/sdl2-2.0.12
	media-libs/freetype
	media-libs/glew
	media-libs/glm
	media-libs/libpng
	x11-libs/cairo
	sys-libs/zlib
	dev-libs/icu"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-9999-cxx-flags.patch
	"${FILESDIR}"/${PN}-9999-server-log-locations.patch
)

src_unpack() {
	unpack ${A}
	mv anura-trunk ${P}
	rm -rf ${P}/imgui
	mv imgui-d7ce9212f1d321a1470c8ab8dceeed222c55a3ce ${P}/imgui
}

src_install() {
	emake DESTDIR="${D}"
	exeinto "${ANURA_PATH}"
	doexe anura
	insinto "${ANURA_PATH}"
	doins -r images modules music data
	dodoc README.md
}
