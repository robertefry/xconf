# Maintainer: Robert E Fry <robert.e.fry@protonmail.com>
pkgname=xconf
pkgver=1.1
pkgrel=1
pkgdesc="Configure and manage Xorg sessions"
arch=('any')
url="https://github.com/robertefry/xconf"
license=('MIT')
depends=('bash' 'sudo' 'xorg-xinit')
install=xconf.install
changelog=CHANGELOG

build()
{
	ln -sr "$srcdir"/../xconf/ "$srcdir"/
}

package()
{
	cd "$srcdir"/xconf/
	for file in $(find -L usr/bin/ -type f); do
		install -Dm755 "$file" "$pkgdir"/"$file"
	done
	for file in $(find -L usr/lib/ -type f); do
		install -Dm755 "$file" "$pkgdir"/"$file"
	done
	for file in $(find -L usr/share/ -type f); do
		install -Dm644 "$file" "$pkgdir"/"$file"
	done
}
