# Distributed under the terms of the GNU General Public License v2
EAPI=7

DESCRIPTION="Chinese Rime Input Method Engine for IBus"
HOMEPAGE="https://rime.im/ https://github.com/rime/ibus-rime"
SRC_URI="https://github.com/rime/ibus-rime/tarball/4392bf71c89d3fa0bfcb539810ada0dc6ad87253 -> ibus-rime-1.5.1-4392bf7.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	app-i18n/ibus
	app-i18n/librime
	app-i18n/rime-plum
	x11-libs/libnotify"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/cmake
	virtual/pkgconfig"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/rime-ibus-rime-* "${S}"
}

src_prepare() {
	sed -i \
		-e "/^libexecdir/s:/lib:/libexec:" \
		-e "/^[[:space:]]*PREFIX/s:/usr:${EPREFIX}/usr:" \
		-e "s/ make/ \$(MAKE)/" Makefile || die

	default
}