_themename=YoRHa-sddm-theme
pkgname=sddm-theme-yorha
pkgver=1.0.1
pkgrel=1
pkgdesc='A YoRHa-themed SDDM login screen'
arch=('any')
url='https://github.com/NeekoKun/YoRHa-sddm-theme'
license=('GPLv3')
depends=('sddm')
backup=("etc/sddm.conf.d/$_themename.conf")
source=("$pkgname-$pkgver.tar.gz::https://github.com/NeekoKun/YoRHa-sddm-theme/archive/v$pkgver.tar.gz")
sha256sums=('SKIP')
install=yorha-sddm-theme.install

package() {
    cd "$srcdir/$_themename-$pkgver"
    install -dm755 "$pkgdir/usr/share/sddm/themes/$_themename"
    cp -r theme/* "$pkgdir/usr/share/sddm/themes/$_themename/"

    install -dm755 "$pkgdir/etc/sddm.conf.d"
    printf '[Theme]\nCurrent=%s\n' "$_themename" > "$pkgdir/etc/sddm.conf.d/$_themename.conf"
}