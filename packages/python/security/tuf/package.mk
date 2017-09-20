################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tuf"
PKG_VERSION="9e63023"
PKG_SHA256="a730ce3fb0d78a00363f9456afe6682c9bf308e60f308a5a1f547fd49c9cc2cf"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://theupdateframework.github.io/"
PKG_URL="https://github.com/theupdateframework/tuf/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host python-securesystemslib python-six python-iso8601"
PKG_SECTION="python/security"
PKG_SHORTDESC="The Update Framework"
PKG_LONGDESC="TUF: Like the S in HTTPS, a plug-and-play library for securing a software updater"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/bin
}
