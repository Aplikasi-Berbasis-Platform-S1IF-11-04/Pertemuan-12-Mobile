<div style="font-family: 'Times New Roman', Times, serif;">

<div align="center">
  <br />

  <h1>LAPORAN PRAKTIKUM <br>
  APLIKASI BERBASIS PLATFORM
  </h1>

  <br />

  <h3>MODUL 12<br>
    Tugas Praktikum — Notifikasi & API Perangkat Keras
  </h3>

  <br />

  <img width="182" height="182" alt="Logo Telkom University Purwokerto" src="logo_telkom_university.jpg" />

  <br />
  <br />
  <br />

  <h3>Disusun Oleh :</h3>

  <p>
    <strong>Haposan Felix Marcel Siregar</strong><br>
    <strong>2311102210</strong><br>
    <strong>S1 IF-11-04</strong>
  </p>

  <br />

  <h3>Dosen Pengampu :</h3>

  <p>
    <strong>Cahyo Prihantoro, S.Kom., M.Eng.</strong>
  </p>

  <br />

  <h3>LABORATORIUM HIGH PERFORMANCE
  <br>FAKULTAS INFORMATIKA <br>UNIVERSITAS TELKOM PURWOKERTO <br>2026</h3>
</div>

<hr>

## 1. Penjelasan Singkat

Pada Modul 12 ini, tugas praktikum berfokus pada penggunaan **API Perangkat Keras** (kamera & galeri) serta **Notifikasi Lokal** pada aplikasi Flutter. Aplikasi yang dibuat memungkinkan pengguna untuk mengambil foto dari kamera atau memilih foto dari galeri perangkat, kemudian menampilkan foto tersebut di layar dan memberikan notifikasi lokal sebagai konfirmasi bahwa proses berhasil dilakukan.

### Package yang Digunakan

| Package | Versi | Fungsi |
|---|---|---|
| `image_picker` | ^1.2.2 | Mengakses kamera dan galeri perangkat untuk mengambil/memilih foto |
| `flutter_local_notifications` | ^22.0.0 | Menampilkan notifikasi lokal di perangkat Android dan iOS |

### Konsep Utama

1. **Image Picker** — Package `image_picker` menyediakan antarmuka yang mudah untuk mengakses kamera (`ImageSource.camera`) atau galeri (`ImageSource.gallery`) perangkat. Method `pickImage()` mengembalikan objek `XFile` yang berisi data file gambar yang dipilih.

2. **Flutter Local Notifications** — Package `flutter_local_notifications` memungkinkan aplikasi menampilkan notifikasi di status bar perangkat tanpa memerlukan koneksi internet atau server push notification. Notifikasi dikonfigurasi melalui `FlutterLocalNotificationsPlugin` yang diinisialisasi saat aplikasi pertama kali berjalan.

3. **Platform Permissions** — Untuk mengakses kamera, galeri, dan menampilkan notifikasi, aplikasi memerlukan permission khusus. Pada Android 13+ (API 33), permission `POST_NOTIFICATIONS` wajib diminta secara runtime melalui `requestNotificationsPermission()`. Pada iOS, permission diminta melalui `requestPermissions()`.

4. **Kompatibilitas Web** — Aplikasi menggunakan `Image.memory()` dan `Uint8List` (bukan `Image.file()`) agar kompatibel dengan platform web.

---

## 2. Langkah-langkah Praktikum

### Langkah 1 — Buat Project Flutter Baru

Buat project Flutter baru dengan nama `notifikasi_foto_app`:

```bash
flutter create notifikasi_foto_app
cd notifikasi_foto_app
```

---

### Langkah 2 — Tambah Dependencies

Buka file `pubspec.yaml` pada project Flutter, lalu tambahkan dua package baru di bagian `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  image_picker: ^1.2.2
  flutter_local_notifications: ^22.0.0
```

Kemudian jalankan:

```bash
flutter pub get
```

---

### Langkah 3 — Konfigurasi Permission Android

Buka file `android/app/src/main/AndroidManifest.xml`, lalu tambahkan permission untuk kamera dan notifikasi:

```xml
<!-- Permission untuk akses kamera -->
<uses-permission android:name="android.permission.CAMERA"/>
<!-- Permission untuk akses galeri / storage -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<!-- Permission untuk notifikasi (Android 13+) -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

> **Catatan:** Permission `CAMERA` wajib agar aplikasi dapat membuka kamera perangkat. Permission `POST_NOTIFICATIONS` diperlukan pada Android 13+ (API 33) untuk menampilkan notifikasi lokal.

---

### Langkah 4 — Konfigurasi Permission iOS

Buka file `ios/Runner/Info.plist`, lalu tambahkan deskripsi permission sebelum tag `</dict>`:

```xml
<key>NSCameraUsageDescription</key>
<string>Aplikasi memerlukan akses kamera untuk mengambil foto</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Aplikasi memerlukan akses galeri untuk memilih foto</string>
```

> Deskripsi ini akan ditampilkan kepada pengguna saat iOS meminta izin akses kamera atau galeri.

---

### Langkah 5 — Tulis Source Code `lib/main.dart`

Ganti isi file `lib/main.dart` dengan kode aplikasi yang meliputi:

1. **Import & inisialisasi plugin notifikasi** di fungsi `main()` sebelum `runApp()`.
2. **Request notification permissions** — Meminta izin notifikasi untuk Android 13+ dan iOS saat startup.
3. **Widget `MyApp`** — Root `MaterialApp` dengan tema Material 3 dan mode gelap.
4. **Widget `HomePage`** — `StatefulWidget` yang mengelola state gambar (`_imageBytes`), animasi, dan loading.
5. **Method `_pickImage()`** — Mengambil gambar dari kamera atau galeri, menyimpan bytes, dan menampilkan notifikasi.
6. **Method `_showNotification()`** — Meminta izin notifikasi terlebih dahulu, lalu mengirim notifikasi lokal melalui `FlutterLocalNotificationsPlugin`.
7. **Widget `_ActionButton`** — Tombol custom dengan gradient, ikon, dan efek hover/scale.

---

### Langkah 6 — Jalankan Aplikasi

1. Sambungkan device atau jalankan emulator.
2. Jalankan:
   ```bash
   flutter run
   ```
3. Tampilan awal menunjukkan placeholder "Belum ada foto" dengan dua tombol: **Buka Kamera** dan **Pilih Galeri**.
4. Tekan tombol **Buka Kamera** → kamera terbuka → ambil foto → foto tampil di layar → notifikasi muncul: *"Foto berhasil diambil dari Kamera!"*.
5. Tekan tombol **Pilih Galeri** → galeri terbuka → pilih foto → foto tampil di layar → notifikasi muncul: *"Foto berhasil diambil dari Galeri!"*.

---

## 3. Struktur Project

```
notifikasi_foto_app/
├── lib/
│   └── main.dart                     # Source code utama aplikasi (kamera + notifikasi)
├── android/app/src/main/
│   └── AndroidManifest.xml           # Permission: CAMERA, READ_EXTERNAL_STORAGE, POST_NOTIFICATIONS
├── ios/Runner/
│   └── Info.plist                    # Permission: NSCameraUsageDescription, NSPhotoLibraryUsageDescription
├── pubspec.yaml                      # Dependencies: image_picker, flutter_local_notifications
├── SS/                               # Folder screenshot hasil tampilan
└── ...
```

---

## 4. Source Code Lengkap

### 4.1 `lib/main.dart`

```dart
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Plugin notifikasi lokal (global instance)
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi flutter_local_notifications
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();
  const LinuxInitializationSettings linuxSettings =
      LinuxInitializationSettings(defaultActionName: 'Open notification');

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
    linux: linuxSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(settings: initSettings);

  // Request notification permissions (required for Android 13+ and iOS)
  if (Platform.isAndroid) {
    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
  } else if (Platform.isIOS) {
    final iosPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(const MyApp());
}

/// Widget MyApp — Root widget aplikasi dengan konfigurasi tema MaterialApp.
/// Mengatur tema warna, font, dan navigasi awal ke HomePage.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifikasi & Foto App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C63FF),
        brightness: Brightness.light,
        fontFamily: 'Segoe UI',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C63FF),
        brightness: Brightness.dark,
        fontFamily: 'Segoe UI',
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

/// Widget HomePage — Halaman utama aplikasi (StatefulWidget).
/// Menampilkan dua tombol untuk mengambil foto (kamera & galeri),
/// area preview foto, dan mengirim notifikasi lokal saat foto berhasil diambil.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /// Instance ImagePicker untuk mengambil gambar
  final ImagePicker _picker = ImagePicker();

  /// Data byte gambar yang diambil (untuk kompatibilitas web)
  Uint8List? _imageBytes;

  /// Nama file gambar yang dipilih
  String? _imageName;

  /// Sumber gambar terakhir (kamera/galeri)
  String? _imageSource;

  /// Status loading saat mengambil gambar
  bool _isLoading = false;

  /// Controller animasi untuk efek fade-in gambar
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  /// Controller animasi untuk efek pulse pada tombol
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Animasi fade-in untuk gambar
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Animasi pulse untuk indikator
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  /// Mengambil gambar dari sumber tertentu (kamera atau galeri).
  /// Setelah berhasil, menampilkan notifikasi lokal.
  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isLoading = true);

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        // Baca file sebagai bytes (kompatibel dengan web)
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _imageName = pickedFile.name;
          _imageSource =
              source == ImageSource.camera ? 'Kamera' : 'Galeri';
          _isLoading = false;
        });

        // Mulai animasi fade-in
        _fadeController.reset();
        _fadeController.forward();

        // Tampilkan notifikasi lokal
        await _showNotification();

        // Tampilkan juga SnackBar sebagai feedback visual di dalam app
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Foto berhasil diambil dari $_imageSource! ✨',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF6C63FF),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Gagal mengambil foto: $e')),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  /// Menampilkan notifikasi lokal menggunakan flutter_local_notifications.
  /// Notifikasi berisi informasi sumber foto (kamera/galeri).
  /// Meminta izin notifikasi terlebih dahulu jika belum diberikan.
  Future<void> _showNotification() async {
    // Pastikan izin notifikasi sudah diberikan sebelum menampilkan
    bool permissionGranted = true;

    if (Platform.isAndroid) {
      final androidPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      permissionGranted =
          await androidPlugin?.requestNotificationsPermission() ?? false;
    } else if (Platform.isIOS) {
      final iosPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      permissionGranted = await iosPlugin?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    if (!permissionGranted) {
      debugPrint('Notification permission not granted');
      return;
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'foto_channel',
      'Foto Notifications',
      channelDescription: 'Notifikasi saat foto berhasil diambil',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: '📸 Foto Berhasil!',
      body: 'Foto telah berhasil diambil dari $_imageSource. Nama file: $_imageName',
      notificationDetails: notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      /// AppBar — Bar navigasi atas dengan judul dan ikon.
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_enhance_rounded, size: 28),
            SizedBox(width: 10),
            Text(
              'Notifikasi & Foto',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      /// Body — Konten utama halaman dengan scroll.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.surface,
              colorScheme.surface.withValues(alpha: 0.95),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  // ── Header Info Card ──
                  _buildInfoCard(colorScheme),
                  const SizedBox(height: 24),

                  // ── Tombol Aksi ──
                  _buildActionButtons(colorScheme),
                  const SizedBox(height: 24),

                  // ── Area Preview Foto ──
                  _buildImagePreview(colorScheme),
                  const SizedBox(height: 24),

                  // ── Info Footer ──
                  _buildFooter(colorScheme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget _buildInfoCard — Card informasi di bagian atas halaman.
  Widget _buildInfoCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.5),
            colorScheme.tertiaryContainer.withValues(alpha: 0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.photo_camera_front_rounded,
            size: 48,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Modul 12 — Praktikum',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Notifikasi & API Perangkat Keras',
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Haposan — 2311102210',
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Widget _buildActionButtons — Dua tombol utama untuk mengambil foto.
  Widget _buildActionButtons(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pilih Sumber Foto',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.camera_alt_rounded,
                label: 'Buka Kamera',
                subtitle: 'Camera API',
                gradient: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.8),
                ],
                isLoading: _isLoading,
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ActionButton(
                icon: Icons.photo_library_rounded,
                label: 'Pilih Galeri',
                subtitle: 'Image Picker',
                gradient: [
                  colorScheme.tertiary,
                  colorScheme.tertiary.withValues(alpha: 0.8),
                ],
                isLoading: _isLoading,
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Widget _buildImagePreview — Area untuk menampilkan foto yang diambil/dipilih.
  Widget _buildImagePreview(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 300),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _imageBytes != null
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outline.withValues(alpha: 0.2),
          width: _imageBytes != null ? 2 : 1,
        ),
        boxShadow: _imageBytes != null
            ? [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: _isLoading
            ? _buildLoadingState(colorScheme)
            : _imageBytes != null
                ? _buildImageDisplay(colorScheme)
                : _buildPlaceholder(colorScheme),
      ),
    );
  }

  /// Widget _buildLoadingState — Indikator loading saat foto sedang diproses.
  Widget _buildLoadingState(ColorScheme colorScheme) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Memproses foto...',
              style: TextStyle(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget _buildImageDisplay — Menampilkan foto yang berhasil diambil.
  Widget _buildImageDisplay(ColorScheme colorScheme) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Image.memory(
            _imageBytes!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer.withValues(alpha: 0.6),
                  colorScheme.tertiaryContainer.withValues(alpha: 0.4),
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _imageSource == 'Kamera'
                      ? Icons.camera_alt_rounded
                      : Icons.photo_library_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sumber: $_imageSource',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        _imageName ?? '',
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green.shade400,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget _buildPlaceholder — Placeholder saat belum ada foto yang diambil.
  Widget _buildPlaceholder(ColorScheme colorScheme) {
    return SizedBox(
      height: 300,
      child: Center(
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _pulseAnimation.value,
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_photo_alternate_rounded,
                size: 64,
                color: colorScheme.primary.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 16),
              Text(
                'Belum ada foto',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tekan tombol di atas untuk\nmengambil atau memilih foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget _buildFooter — Footer informasi di bagian bawah halaman.
  Widget _buildFooter(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeatureChip(Icons.camera_alt, 'Camera API', colorScheme),
              const SizedBox(width: 8),
              _buildFeatureChip(Icons.image, 'Image Picker', colorScheme),
              const SizedBox(width: 8),
              _buildFeatureChip(
                  Icons.notifications_active, 'Local Notif', colorScheme),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Modul 12 • Aplikasi Berbasis Platform',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget _buildFeatureChip — Chip kecil untuk menampilkan fitur yang digunakan.
  Widget _buildFeatureChip(
    IconData icon,
    String label,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget _ActionButton — Tombol aksi dengan gradient, ikon, dan label.
/// Memiliki efek hover scale dan shadow.
class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final List<Color> gradient;
  final bool isLoading;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0),
        transformAlignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.gradient[0]
                        .withValues(alpha: _isHovered ? 0.4 : 0.25),
                    blurRadius: _isHovered ? 16 : 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.icon,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

### 4.2 `pubspec.yaml` (Bagian Dependencies)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  image_picker: ^1.2.2
  flutter_local_notifications: ^22.0.0
```

---

## 5. Penjelasan Widget & Komponen

| Widget / Komponen | Lokasi | Fungsi |
|---|---|---|
| `FlutterLocalNotificationsPlugin` | `main.dart` (top-level) | Plugin global untuk mengelola notifikasi lokal Android & iOS |
| `WidgetsFlutterBinding.ensureInitialized()` | `main()` | Memastikan binding Flutter siap sebelum inisialisasi plugin async |
| `AndroidInitializationSettings` | `main()` | Konfigurasi ikon notifikasi Android (`@mipmap/ic_launcher`) |
| `DarwinInitializationSettings` | `main()` | Konfigurasi notifikasi iOS |
| `requestNotificationsPermission()` | `main()` & `_showNotification()` | Meminta izin notifikasi runtime (wajib Android 13+) |
| `MaterialApp` | `MyApp` | Root widget dengan tema Material 3, dark mode, dan seed color `0xFF6C63FF` |
| `Scaffold` | `HomePage` | Struktur halaman (AppBar + Body) |
| `AppBar` + `LinearGradient` | `HomePage` | Bar navigasi atas dengan gradient warna primary → tertiary |
| `SingleChildScrollView` | `HomePage` | Membungkus konten agar bisa di-scroll |
| `ConstrainedBox` | `HomePage` | Membatasi lebar maksimum konten (500px) agar responsif |
| `_buildInfoCard()` | `HomePage` | Card informasi modul di bagian atas |
| `_buildActionButtons()` | `HomePage` | Dua tombol: Buka Kamera & Pilih Galeri |
| `_buildImagePreview()` | `HomePage` | Area preview foto dengan loading, placeholder, dan display state |
| `_buildFooter()` | `HomePage` | Footer dengan chip fitur (Camera API, Image Picker, Local Notif) |
| `Image.memory()` | `_buildImageDisplay()` | Menampilkan gambar dari byte data (`Uint8List`) — kompatibel web |
| `FadeTransition` | `_buildImageDisplay()` | Animasi fade-in saat gambar pertama kali ditampilkan |
| `AnimatedBuilder` + pulse | `_buildPlaceholder()` | Animasi pulse pada placeholder "Belum ada foto" |
| `_ActionButton` | Widget custom | Tombol gradient dengan ikon, label, subtitle, dan efek hover scale |
| `MouseRegion` | `_ActionButton` | Mendeteksi hover mouse untuk efek animasi (web) |
| `AnimatedContainer` | `_ActionButton` | Container dengan animasi scale otomatis saat hover |
| `SnackBar` (floating) | `_pickImage()` | Feedback visual di dalam app setelah foto berhasil diambil |
| `CircularProgressIndicator` | `_buildLoadingState()` | Indikator loading saat foto sedang diproses |

---

## 6. Alur Kerja Aplikasi

```
┌─────────────────────────────┐
│   User membuka aplikasi     │
│   (Tampil placeholder)      │
└──────────┬──────────────────┘
           │
           ▼
┌─────────────────────────────┐
│  Request notification       │
│  permissions (Android/iOS)  │
└──────────┬──────────────────┘
           │
     ┌─────┴─────┐
     ▼           ▼
┌─────────┐ ┌──────────┐
│ Tombol  │ │ Tombol   │
│ Kamera  │ │ Galeri   │
└────┬────┘ └────┬─────┘
     │           │
     ▼           ▼
┌─────────┐ ┌──────────┐
│ Buka    │ │ Buka     │
│ Kamera  │ │ Galeri   │
│ Device  │ │ Device   │
└────┬────┘ └────┬─────┘
     │           │
     ▼           ▼
┌─────────────────────────────┐
│  User ambil / pilih foto    │
│  (readAsBytes → Uint8List)  │
└──────────┬──────────────────┘
           │
     ┌─────┴─────┐
     ▼           ▼
┌─────────┐ ┌──────────────┐
│ Foto    │ │ Notifikasi   │
│ tampil  │ │ lokal muncul │
│ di UI   │ │ di status bar│
└─────────┘ └──────────────┘
     │
     ▼
┌─────────────────────────────┐
│ SnackBar feedback muncul    │
│ di dalam aplikasi           │
└─────────────────────────────┘
```

---

## 7. Cara Menjalankan

1. Pastikan Flutter SDK sudah terinstal dan device/emulator tersedia.
2. Buka terminal di folder `notifikasi_foto_app/`.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```
5. Tekan tombol **Buka Kamera** → ambil foto → foto tampil + notifikasi muncul.
6. Tekan tombol **Pilih Galeri** → pilih foto → foto tampil + notifikasi muncul.
7. Ambil screenshot untuk dilampirkan di folder `SS/`.

---

## 8. Screenshot Hasil Tampilan

<br>

<div align="center">

| No | Deskripsi | Screenshot |
|:---:|:---|:---:|
| 1 | Tampilan awal aplikasi (placeholder) | <img src="SS/tampilan_awal.png" alt="Tampilan Awal" width="250" /> |
| 2 | Membuka kamera perangkat | <img src="SS/kamera.png" alt="Kamera" width="250" /> |
| 3 | Foto berhasil diambil dari kamera | <img src="SS/hasil_kamera.png" alt="Hasil Kamera" width="250" /> |
| 4 | Notifikasi setelah ambil foto kamera | <img src="SS/notif_kamera.png" alt="Notifikasi Kamera" width="250" /> |
| 5 | Foto berhasil dipilih dari galeri | <img src="SS/hasil_galeri.png" alt="Hasil Galeri" width="250" /> |
| 6 | Notifikasi setelah pilih foto galeri | <img src="SS/notif_galeri.png" alt="Notifikasi Galeri" width="250" /> |

</div>

<br>

> **Catatan:** Screenshot di atas perlu diambil secara manual oleh praktikan setelah menjalankan aplikasi di device/emulator, lalu disimpan ke folder `SS/` dengan nama file sesuai tabel.

---

## 9. Kesimpulan

Pada tugas praktikum Modul 12 ini, berhasil diimplementasikan aplikasi Flutter yang menggabungkan **API Perangkat Keras** dan **Notifikasi Lokal**. Beberapa hal yang dicapai:

1. **Image Picker** berhasil diimplementasikan menggunakan package `image_picker` untuk mengakses kamera (`ImageSource.camera`) dan galeri (`ImageSource.gallery`) perangkat. Foto yang diambil/dipilih dibaca sebagai `Uint8List` dan ditampilkan di UI menggunakan `Image.memory()` agar kompatibel dengan platform web.

2. **Flutter Local Notifications** berhasil diimplementasikan menggunakan package `flutter_local_notifications`. Notifikasi lokal ditampilkan secara otomatis setelah pengguna berhasil mengambil foto dari kamera atau memilih foto dari galeri, tanpa memerlukan koneksi internet atau server push notification.

3. **Platform Permissions** dikonfigurasi dengan benar:
   - **Android**: Permission `CAMERA`, `READ_EXTERNAL_STORAGE`, dan `POST_NOTIFICATIONS` (Android 13+) dengan runtime request melalui `requestNotificationsPermission()`.
   - **iOS**: Permission `NSCameraUsageDescription` dan `NSPhotoLibraryUsageDescription` di `Info.plist`, serta runtime request melalui `requestPermissions()`.

4. Aplikasi menggunakan **Material Design 3** dengan tema gelap, gradient, animasi fade-in & pulse, efek hover pada tombol, floating SnackBar, dan UI responsif yang premium.

</div>
