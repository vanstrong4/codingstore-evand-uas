# Evand Coding Store

Evand Coding Store adalah aplikasi e-commerce berbasis Flutter yang menyediakan katalog produk digital dan mendukung proses pembelian menggunakan Firebase Authentication, Cloud Firestore, serta integrasi Google Authenticator sebagai verifikasi keamanan saat checkout.

Link Demo Aplikasi : https://www.youtube.com/watch?v=X-7YKp_WeaE

## Fitur

* Login dan Register menggunakan Email/Password
* Login menggunakan Google
* Verifikasi Email
* Menampilkan katalog produk secara real-time
* Keranjang belanja
* Checkout produk
* Riwayat transaksi
* Integrasi Firebase Authentication
* Cloud Firestore sebagai database
* Verifikasi transaksi menggunakan Google Authenticator (TOTP)

## Teknologi

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Google Sign-In
* Provider
* OTP (TOTP)
* QR Flutter

## Struktur Project

```text
lib/
│
├── core/
│   └── theme/
│
├── data/
│   ├── models/
│   ├── providers/
│   └── services/
│
├── features/
│   ├── auth/
│   └── catalog/
│
└── widgets/
```

## Firebase Collections

### users

```text
uid
email
name
isVerified
authProvider
createdAt
```

### wallets

```text
userId
email
balance
pin
authSecret
createdAt
```

### transactions

```text
userId
items
total
status
createdAt
```

## Screenshot

### Login


<img width="494" height="642" alt="Screenshot 2026-06-29 215007" src="https://github.com/user-attachments/assets/62a5bb00-1e8d-46f5-875f-724d388c34e7" />


---

### Register


<img width="493" height="645" alt="Screenshot 2026-06-29 215019" src="https://github.com/user-attachments/assets/09bb4852-b6d3-4482-b03c-35fe3bca28bb" />


---

### Home


<img width="493" height="641" alt="Screenshot 2026-06-29 215819" src="https://github.com/user-attachments/assets/0ae753cf-9765-46d4-a779-3fa9604ff78a" />


---

### Cart


<img width="482" height="636" alt="Screenshot 2026-06-29 215959" src="https://github.com/user-attachments/assets/4652eb81-875b-43bd-8aa1-740ec322f595" />


---

### Checkout


<img width="487" height="643" alt="Screenshot 2026-06-29 220023" src="https://github.com/user-attachments/assets/73939eca-7eab-4ac9-9f29-b3f0cc3c6698" />


---

### Google Authenticator


<img width="487" height="643" alt="Screenshot 2026-06-29 220636" src="https://github.com/user-attachments/assets/9d1c1ee7-4374-43cd-a922-d72c63cce2a4" />
<img width="482" height="625" alt="Screenshot 2026-06-29 220030" src="https://github.com/user-attachments/assets/2ea15ce4-957a-4e91-b864-aaff59b54dc5" />
<img width="481" height="639" alt="Screenshot 2026-06-29 215835" src="https://github.com/user-attachments/assets/dd942d1d-9e0e-496f-98b5-c4aa89cb4935" />


---

### Transaction History

<img width="489" height="338" alt="image" src="https://github.com/user-attachments/assets/5d8fd416-a97c-4f4f-9c77-489d735c0f47" />

