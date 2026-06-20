# Evan Coding Machine Store

Aplikasi marketplace sederhana berbasis Flutter dengan integrasi Firebase dan penerapan Clean Architecture serta State Management menggunakan Provider.

---

# Demo Aplikasi

Link video youtube:

https://youtu.be/ZLU4itxgJ-E

Video menampilkan:

* Register dan verifikasi email
* Login
* Tampilan catalog
* Penggunaan cart
* Proses checkout

---

# 1. Arsitektur Aplikasi

Aplikasi menggunakan pendekatan Clean Architecture dengan pemisahan layer sebagai berikut:

## Struktur Folder

```id="s1"
lib/
│
├── data/
│   ├── models/
│   ├── services/
│   ├── providers/
│
├── presentation/
│   ├── auth/
│   ├── catalog/
│   ├── cart/
│
├── widgets/
│
└── main.dart
```

## Penjelasan Layer

* Data Layer
  Mengelola model, service (Firebase), dan provider.

* Presentation Layer
  Berisi tampilan UI (screen) seperti login, home, cart, dan checkout.

* Widgets
  Komponen yang dapat digunakan kembali seperti button, textfield, card, dan appbar.

---

# 2. Fitur Aplikasi

## Authentication (Firebase)

* Register menggunakan email dan password
* Verifikasi email wajib sebelum login
* Login menggunakan email dan password
* Login menggunakan Google

## Catalog

* Menampilkan daftar produk dari Firebase Firestore
* Data produk terdiri dari:

  * Nama
  * Harga
  * Deskripsi
  * Gambar

## Cart

* Menambahkan produk ke keranjang
* Menghapus produk dari keranjang
* Menghitung total harga
* Menggunakan Provider untuk state management

## Checkout

* Menampilkan daftar item yang dipilih
* Menampilkan total harga
* Simulasi checkout berhasil
* Keranjang dikosongkan setelah checkout

---

# 3. Penjelasan Code

## Provider

State management menggunakan Provider dengan ChangeNotifier.

Contoh:

* CartProvider menyimpan daftar item
* Setiap perubahan data akan memanggil notifyListeners()
* UI akan otomatis melakukan rebuild

## State Flow

```id="s2"
Login → Firebase Authentication → Generate Token
      → Home (Catalog)
      → Add to Cart
      → Cart Screen
      → Checkout
      → Clear Cart
```

## API Integration

Alur integrasi API pada aplikasi:

```id="s3"
Login → Firebase Authentication
      → Generate Access Token (simulasi JWT)
      → Digunakan untuk kebutuhan request berikutnya
```

Token dibuat di sisi client sebagai simulasi. Pada implementasi nyata, token seharusnya dibuat di backend menggunakan secret key untuk alasan keamanan.

---

# Teknologi yang Digunakan

* Flutter
* Firebase Authentication
* Firebase Firestore
* Firebase Cloud Messaging (FCM)
* Provider
* Crypto (HMAC SHA256) untuk JWT

---

# Kesimpulan

Aplikasi ini telah memenuhi seluruh kebutuhan project:

* Authentication dengan verifikasi email
* Catalog produk
* Cart dan checkout
* State management menggunakan Provider
* Integrasi Firebase
* API menggunakan JWT

