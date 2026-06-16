<h3 align="center">LAPORAN PRAKTIKUM</h3>
<h3 align="center">APLIKASI BERBASIS PLATFORM</h3>
<h3 align="center">Modul 8 & 9</h3>
<h3 align="center">API PERANGKAT KERAS</h3>

<br>
<p align="center">
  <img src="output/logo telkom university.png" width="150"/>
</p>
<br>

<p align="center">
Disusun oleh:
<br><br>
Muhammad Rafiful Hana
<br>
2311102227
<br>
S1 IF-11-04
</p>

<br>

<p align="center">
Dosen Pengampu:
<br>
Cahyo Prihantoro, S.Kom., M.Eng
</p>

<br><br>

<p align="center">
PROGRAM STUDI S1 INFORMATIKA
<br>
FAKULTAS INFORMATIKA
<br>
TELKOM UNIVERSITY PURWOKERTO
<br>
2026
</p>

---

# Dependencies yang Digunakan

Pada project ini digunakan beberapa package tambahan yang terdapat pada file `pubspec.yaml`.

## 1. image_picker

```yaml
image_picker: ^1.2.0
```

### Fungsi

Package ini digunakan untuk:

* Membuka kamera perangkat.
* Mengambil foto menggunakan kamera.
* Membuka galeri perangkat.
* Memilih gambar dari galeri.

### Import

```dart
import 'package:image_picker/image_picker.dart';
```

### Implementasi

```dart
final ImagePicker picker = ImagePicker();
```

---

## 2. flutter_local_notifications

```yaml
flutter_local_notifications: ^19.4.0
```

### Fungsi

Package ini digunakan untuk:

* Menampilkan notifikasi lokal.
* Memberikan informasi ketika foto berhasil dipilih.
* Memberikan informasi ketika foto berhasil diambil.

### Import

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
```

### Implementasi

```dart
final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();
```

---

## 3. google_fonts

```yaml
google_fonts: ^6.3.1
```

### Fungsi

Package ini digunakan untuk:

* Mengubah font default Flutter.
* Menggunakan font Poppins.
* Membuat tampilan aplikasi lebih modern.

### Import

```dart
import 'package:google_fonts/google_fonts.dart';
```

### Implementasi

```dart
GoogleFonts.poppins()
```

---

# Import Library yang Digunakan

Pada aplikasi ini digunakan beberapa library berikut:

## Dart IO

```dart
import 'dart:io';
```

### Fungsi

Digunakan untuk:

* Membaca file gambar dari perangkat.
* Menampilkan file gambar menggunakan widget Image.file.

---

## Material Design

```dart
import 'package:flutter/material.dart';
```

### Fungsi

Digunakan untuk:

* Widget dasar Flutter.
* Membuat tampilan aplikasi.
* Mengatur tema aplikasi.

---

## Image Picker

```dart
import 'package:image_picker/image_picker.dart';
```

### Fungsi

Digunakan untuk mengakses kamera dan galeri perangkat.

---

## Flutter Local Notifications

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
```

### Fungsi

Digunakan untuk membuat notifikasi lokal pada Android.

---

## Google Fonts

```dart
import 'package:google_fonts/google_fonts.dart';
```

### Fungsi

Digunakan untuk mengganti font bawaan Flutter menjadi Google Font.

---

# Permission yang Dibutuhkan

Aplikasi membutuhkan beberapa permission Android.

Tambahkan pada file:

```text
android/app/src/main/AndroidManifest.xml
```

### Permission Kamera

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

Digunakan untuk:

* Membuka kamera perangkat.
* Mengambil foto.

---

### Permission Notifikasi

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

Digunakan untuk:

* Menampilkan notifikasi lokal.

---

# Widget yang Digunakan

Berikut widget utama yang digunakan dalam project:

| Widget                | Fungsi                               |
| --------------------- | ------------------------------------ |
| MaterialApp           | Root aplikasi Flutter                |
| Scaffold              | Kerangka halaman                     |
| Container             | Area tampilan dan dekorasi           |
| SafeArea              | Menghindari notch dan status bar     |
| SingleChildScrollView | Membuat halaman dapat di-scroll      |
| Column                | Menyusun widget secara vertikal      |
| Row                   | Menyusun widget secara horizontal    |
| Text                  | Menampilkan teks                     |
| Icon                  | Menampilkan ikon                     |
| CircleAvatar          | Menampilkan ikon berbentuk lingkaran |
| InkWell               | Membuat tombol interaktif            |
| Expanded              | Mengisi ruang kosong                 |
| ClipRRect             | Membuat sudut melengkung             |
| Image.file            | Menampilkan gambar dari perangkat    |
| InteractiveViewer     | Zoom gambar                          |
| SnackBar              | Menampilkan pesan singkat            |
| LinearGradient        | Membuat warna gradasi                |
| BoxDecoration         | Memberikan dekorasi widget           |

---

# Penjelasan Source Code

## 1. Fungsi Main

Kode:

```dart
void main() {
  runApp(const MyApp());
}
```

Penjelasan:

Fungsi `main()` merupakan entry point dari aplikasi Flutter. Ketika aplikasi dijalankan, Flutter akan menjalankan widget `MyApp` sebagai root widget aplikasi.

---

## 2. Konfigurasi MaterialApp

Kode:

```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Coffee Photo',
  theme: ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
  ),
  home: const HomePage(),
);
```

Penjelasan:

Widget `MaterialApp` digunakan sebagai widget utama aplikasi.

Fungsi dari setiap properti:

* `debugShowCheckedModeBanner: false` digunakan untuk menghilangkan banner DEBUG.
* `title` digunakan untuk memberikan nama aplikasi.
* `theme` digunakan untuk mengatur tema aplikasi dengan warna coklat dan font Poppins.
* `home` menentukan halaman pertama yang dibuka.

---

## 3. Deklarasi Variabel

Kode:

```dart
final ImagePicker picker = ImagePicker();

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

File? imageFile;

String fileName = "";
String lastAction = "";
```

Penjelasan:

Variabel yang digunakan pada aplikasi:

* `picker` digunakan untuk mengakses kamera dan galeri.
* `notifications` digunakan untuk menampilkan notifikasi lokal.
* `imageFile` digunakan untuk menyimpan file gambar yang dipilih.
* `fileName` digunakan untuk menyimpan nama file gambar.
* `lastAction` digunakan untuk menyimpan status sumber gambar.

---

## 4. Inisialisasi Notifikasi

Kode:

```dart
Future<void> initializeNotification() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
      InitializationSettings(
    android: androidSettings,
  );

  await notifications.initialize(settings);

  final androidPlugin =
      notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  await androidPlugin?.requestNotificationsPermission();
}
```

Penjelasan:

Fungsi ini digunakan untuk:

* Menginisialisasi plugin notifikasi.
* Mengatur ikon notifikasi.
* Meminta izin notifikasi pada Android.

---

## 5. Menampilkan Notifikasi

Kode:

```dart
Future<void> showNotification(String message) async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'coffee_channel',
    'Coffee Notification',
    channelDescription: 'Notifikasi Coffee',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails details =
      NotificationDetails(
    android: androidDetails,
  );

  await notifications.show(
    0,
    'Coffee Photo',
    message,
    details,
  );
}
```

Penjelasan:

Fungsi ini digunakan untuk menampilkan notifikasi lokal ketika foto berhasil dipilih atau diambil.

---

## 6. Menampilkan Snackbar

Kode:

```dart
void showSnack(String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.brown,
    ),
  );
}
```

Penjelasan:

Snackbar digunakan sebagai informasi singkat kepada pengguna ketika proses berhasil dilakukan.

---

## 7. Membuka Kamera

Kode:

```dart
Future<void> openCamera() async {
  final XFile? photo = await picker.pickImage(
    source: ImageSource.camera,
    imageQuality: 80,
  );

  if (photo != null) {
    setState(() {
      imageFile = File(photo.path);
      fileName = photo.name;
      lastAction = "Diambil dari Kamera";
    });

    await showNotification(
      "Foto coffee berhasil diambil",
    );

    showSnack(
      "Foto coffee berhasil diambil",
    );
  }
}
```

Penjelasan:

Fungsi ini digunakan untuk:

* Membuka kamera perangkat.
* Mengambil foto.
* Menyimpan foto ke variabel `imageFile`.
* Menampilkan notifikasi.
* Menampilkan snackbar.

---

## 8. Membuka Galeri

Kode:

```dart
Future<void> openGallery() async {
  final XFile? photo = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

  if (photo != null) {
    setState(() {
      imageFile = File(photo.path);
      fileName = photo.name;
      lastAction = "Dipilih dari Galeri";
    });

    await showNotification(
      "Foto coffee berhasil dipilih",
    );

    showSnack(
      "Foto coffee berhasil dipilih",
    );
  }
}
```

Penjelasan:

Fungsi ini digunakan untuk:

* Membuka galeri perangkat.
* Memilih gambar.
* Menampilkan preview gambar.
* Menampilkan notifikasi.
* Menampilkan snackbar.

---

## 9. Widget Tombol Menu

Kode:

```dart
Widget menuButton({
  required String title,
  required String subtitle,
  required IconData icon,
  required VoidCallback onTap,
})
```

Penjelasan:

Widget ini digunakan untuk membuat tombol:

* Ambil Foto Coffee
* Pilih dari Galeri

agar memiliki desain yang sama dan lebih efisien.

---

## 10. Tampilan Header

Kode:

```dart
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: const LinearGradient(
      colors: [
        Color(0xff4F46E5),
        Color(0xff8B5CF6),
      ],
    ),
  ),
)
```

Penjelasan:

Container ini digunakan sebagai header utama aplikasi yang menampilkan:

* Icon coffee
* Judul aplikasi "Coffee Photo"
* Nama mahasiswa
* NIM

---

## 11. Tombol Ambil Foto

Kode:

```dart
menuButton(
  title: "Ambil Foto Coffee",
  subtitle: "Gunakan kamera perangkat",
  icon: Icons.camera_alt,
  onTap: openCamera,
),
```

Penjelasan:

Ketika tombol ditekan, fungsi `openCamera()` akan dijalankan.

---

## 12. Tombol Pilih Galeri

Kode:

```dart
menuButton(
  title: "Pilih dari Galeri",
  subtitle: "Pilih foto coffee dari galeri",
  icon: Icons.photo_library,
  onTap: openGallery,
),
```

Penjelasan:

Ketika tombol ditekan, fungsi `openGallery()` akan dijalankan.

---

## 13. Preview Foto

Kode:

```dart
Image.file(
  imageFile!,
  width: double.infinity,
  height: double.infinity,
  fit: BoxFit.contain,
)
```

Penjelasan:

Widget ini digunakan untuk menampilkan gambar yang berhasil dipilih pengguna.

---

## 14. InteractiveViewer

Kode:

```dart
InteractiveViewer(
  child: Image.file(
    imageFile!,
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.contain,
  ),
)
```

Penjelasan:

Widget ini memungkinkan pengguna melakukan zoom in dan zoom out pada gambar.

---

## 15. Status Foto

Kode:

```dart
Text(
  fileName,
)
```

dan

```dart
Text(
  lastAction,
)
```

Penjelasan:

Digunakan untuk menampilkan:

* Nama file gambar.
* Informasi apakah gambar berasal dari kamera atau galeri.
  
# Screenshot Hasil Program

### Output 1 - Ambil Foto (Camera API)

<img src="output/output%201.jpeg" width="250">

Foto berhasil diambil menggunakan kamera perangkat.

---

### Output 2 - Pilih Foto (Gallery API)

<img src="output/output%202.jpeg" width="250">

Foto berhasil dipilih dari galeri perangkat.