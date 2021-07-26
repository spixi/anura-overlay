# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ANURA_PATH="/usr/lib/anura"
MY_PV="2e986f97d63e5e0f5944c8fb5e8e2513864098a6"
MY_PV_IMGUI="d7ce9212f1d321a1470c8ab8dceeed222c55a3ce"
DESCRIPTION="Anura is a fully-featured game engine, free for commercial and non-commercial use"
HOMEPAGE="https://github.com/anura-engine/anura"
SRC_URI="https://github.com/anura-engine/anura/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/anura-engine/imgui/archive/${MY_PV_IMGUI}.tar.gz -> imgui.tar.gz"

LICENSE="ZLIB MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/boost-1.50.0
	!>dev-libs/boost-1.67.0
	media-libs/libsdl2
	>=media-libs/sdl2-image-2.0.5[png]
	>=media-libs/sdl2-mixer-2.0.0[vorbis]
	>=media-libs/sdl2-2.0.12
	media-libs/freetype
	media-libs/glew
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
    "${FILESDIR}"/${PN}-9999-fix-c++17.patch
)

src_unpack() {
	unpack ${A}
	mv anura-${MY_PV} ${P}
	rm -rf ${P}/imgui
	mv imgui-${MY_PV_IMGUI} ${P}/imgui
}

src_install() {
	emake DESTDIR="${D}"
	exeinto "${ANURA_PATH}"
	doexe anura
	insinto "${ANURA_PATH}"
	doins -r images modules music data
	dodoc README.md
}
