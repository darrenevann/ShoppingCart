# 🛒 Shopping Cart Flutter App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

Aplikasi e-commerce sederhana berbasis Flutter yang mendemonstrasikan fungsionalitas antarmuka keranjang belanja. Proyek ini memuat katalog produk dasar dan mengimplementasikan manajemen antarmuka pengguna yang terstruktur.

## ✨ Fitur Utama

* **Katalog Produk:** Menampilkan daftar produk dengan aset visual statis (laptop, headphone, mouse).
* **Keranjang Belanja:** Simulasi penambahan, pengurangan, dan kalkulasi item di dalam keranjang.
* **UI Responsif:** Antarmuka yang beradaptasi dengan dimensi layar perangkat.

## 🚀 Memulai Proyek

### Prasyarat

Pastikan lingkungan pengembangan Anda telah terpasang dan dikonfigurasi dengan benar:
* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* [Dart SDK](https://dart.dev/get-dart)
* Editor teks atau IDE (Android Studio / VS Code)

### Instalasi dan Eksekusi

1. Buka terminal dan arahkan ke direktori root proyek.
   ```bash
   cd shoppingcart
   ```
2. Unduh semua dependensi yang dideklarasikan.
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi pada emulator atau perangkat keras yang terhubung.
   ```bash
   flutter run
   ```

## 📁 Struktur Direktori

```text
shoppingcart/
├── android/           # Konfigurasi spesifik kompilasi native Android
├── asset/
│   └── images/        # Penyimpanan aset gambar (laptop.png, headphone.png, mouse.jpg)
├── lib/
│   └── main.dart      # Titik masuk utama (entry point) aplikasi
├── test/              # Direktori pengujian kode (widget test)
└── pubspec.yaml       # Berkas konfigurasi utama untuk dependensi dan aset
```

## 🖼️ Manajemen Aset

Setiap penambahan gambar atau aset statis baru harus dideklarasikan di dalam file `pubspec.yaml` agar sistem Flutter dapat merendernya. Konfigurasi saat ini menggunakan blok berikut:

```yaml
flutter:
  assets:
    - asset/images/
```
