# Yankı

ASP.NET Web Forms (.NET Framework 4.7.2) ile yazılmış, Twitter/X benzeri küçük bir sosyal medya uygulaması.

## Özellikler

- Kayıt olma ve giriş yapma (şifreler BCrypt ile saklanır)
- Gönderi paylaşma (metin ve resim), beğenme, yorum yapma, repost
- Kullanıcı takip etme ve takipçi/takip edilen listeleri
- Profil sayfası, profil resmi değiştirme, şifre değiştirme, tema (açık/koyu) seçimi
- Kullanıcı arama ve mesajlar sayfası

## Gereksinimler

- Visual Studio 2022 veya üstü
- .NET Framework 4.7.2
- SQL Server (SQL Server Express yeterli)

## Kurulum

1. Depoyu klonlayın ve `Yankı.slnx` dosyasını Visual Studio ile açın.
2. NuGet paketleri otomatik yüklenir (yüklenmezse: Çözüm → NuGet Paketlerini Geri Yükle).
3. SQL Server'da `Yankı/Yanki_Database.sql` dosyasını çalıştırarak veritabanını oluşturun.
4. `Yankı/Web.config` içindeki `YankiDB` bağlantı dizesinde `Data Source` değerini kendi SQL Server adınıza göre değiştirin.
5. Projeyi çalıştırın (F5).

## Notlar

- Yüklenen resimler `Yankı/Images` klasörüne kaydedilir. Yalnızca `.png`, `.jpg`, `.jpeg` ve en fazla 5 MB kabul edilir.
- Depoya büyük resim dosyaları göndermemeye dikkat edin, depo boyutu hızla büyür.
