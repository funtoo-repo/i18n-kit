# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools

DESCRIPTION="Intelligent phonetic (Zhuyin/Bopomofo) input method library"
HOMEPAGE="http://chewing.im/ https://github.com/chewing/libchewing"
SRC_URI="https://github.com/chewing/libchewing/releases/download/v0.9.1/libchewing-0.9.1.tar.zst -> libchewing-0.9.1.tar.zst"

LICENSE="LGPL-2.1"
SLOT="0/3"
KEYWORDS="*"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig"
RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}
	test? ( sys-libs/ncurses )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# libchewing.a is required for building of tests.
	econf \
		--with-sqlite3 \
		$(if use static-libs || use test; then echo --enable-static; else echo --disable-static; fi)
}

src_install() {
	default
	find "${D}" -name "*.la" -type f -delete || die
	if ! use static-libs; then
		find "${D}" -name "*.a" -type f -delete || die
	fi
}
