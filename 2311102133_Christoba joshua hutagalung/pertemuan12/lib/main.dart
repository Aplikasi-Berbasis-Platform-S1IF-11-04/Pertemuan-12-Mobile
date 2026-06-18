import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 1. Inisialisasi plugin notifikasi secara global
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // Wajib ditambahkan jika main() menggunakan async
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Setup pengaturan notifikasi (pakai icon bawaan Android)
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Gabungkan pengaturan
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  // Jalankan inisialisasi
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prak ABP - Kamera & Notifikasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KameraScreen(),
    );
  }
}

class KameraScreen extends StatefulWidget {
  const KameraScreen({super.key});

  @override
  State<KameraScreen> createState() => _KameraScreenState();
}

class _KameraScreenState extends State<KameraScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // 3. Fungsi memunculkan Notifikasi Sistem (Local Notification)
  Future<void> _tampilkanNotifSistem() async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'channel_praktikum_abp', // ID Channel
        'Notifikasi Praktikum', // Nama Channel
        channelDescription: 'Channel untuk notifikasi pilih gambar',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0, // ID Notifikasi
        'Berhasil! 📸', // Judul Notifikasi
        'Gambar telah sukses dipilih', // Isi pesan
        platformChannelSpecifics,
      );
    } catch (e) {
      debugPrint("Gagal memunculkan notifikasi: $e");
    }
  }

  // Fungsi untuk membuka kamera
  Future<void> _bukaKamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
        // Panggil notifikasi setelah gambar di-set
        await _tampilkanNotifSistem();
      }
    } catch (e) {
      debugPrint("Error saat membuka kamera: $e");
    }
  }

  // Fungsi untuk membuka galeri
  Future<void> _bukaGaleri() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, 
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
        // Panggil notifikasi setelah gambar di-set
        await _tampilkanNotifSistem();
      }
    } catch (e) {
      debugPrint("Error saat membuka galeri: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum ABP: Kamera & Galeri'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[200],
                ),
                child: _imageFile == null
                    ? const Center(child: Text('Belum ada foto'))
                    : (kIsWeb 
                        ? Image.network(_imageFile!.path, fit: BoxFit.cover) 
                        : Image.file(File(_imageFile!.path), fit: BoxFit.cover) 
                      ),
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _bukaKamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Kamera'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _bukaGaleri,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}