# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE="sqlite(+)"

inherit gnome2-utils python-single-r1 xdg

DESCRIPTION="Tables engines for IBus"
HOMEPAGE="https://github.com/ibus/ibus/wiki"
SRC_URI="https://github.com/kaio/ibus-table/releases/download/1.17.11/ibus-table-1.17.11.tar.gz -> ibus-table-1.17.11.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="nls"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		app-i18n/ibus[python(+),${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	virtual/libiconv
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	python_fix_shebang .

	default
}

src_configure() {
	econf $(use_enable nls)
}

pkg_preinst() {
	xdg_pkg_preinst
    gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
    gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
    gnome2_schemas_update
}