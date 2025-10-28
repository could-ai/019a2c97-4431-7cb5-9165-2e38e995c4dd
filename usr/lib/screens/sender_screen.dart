import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io' if (dart.library.html) 'dart:html';

class SenderScreen extends StatefulWidget {
  const SenderScreen({super.key});

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  PlatformFile? _selectedFile;
  String? _magnetUri;
  String? _landingUrl;
  String _userName = 'المستخدم';
  bool _isSeeding = false;
  int _peers = 0;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  void _startSeeding() {
    if (_selectedFile == null) return;
    setState(() {
      _isSeeding = true;
      _magnetUri = 'magnet:?xt=urn:btih:EXAMPLE_HASH&dn=${_selectedFile!.name}';
      _landingUrl = 'https://example.com/landing?magnet=$_magnetUri&from=$_userName';
      // Placeholder for WebTorrent seeding logic using JS interop
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0b74ff), Color(0xFF6dd8ff)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Center(
                  child: Text(
                    'T',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('T-Share'),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'اسمك',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _userName = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.file_upload),
                label: const Text('اختر ملف'),
              ),
              if (_selectedFile != null) ...[
                const SizedBox(height: 10),
                Text('اسم الملف: ${_selectedFile!.name}'),
                Text('الحجم: ${(_selectedFile!.size / 1024 / 1024).toStringAsFixed(2)} MB'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _startSeeding,
                  child: const Text('ابدأ الإرسال'),
                ),
              ],
              if (_isSeeding) ...[
                const SizedBox(height: 20),
                const Text('جارٍ الإرسال...'),
                Text('عدد الـPeers: $_peers'),
                const SizedBox(height: 20),
                TextField(
                  controller: TextEditingController(text: _magnetUri),
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Magnet URI',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => Share.share(_landingUrl!),
                      child: const Text('مشاركة الرابط'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => launchUrl(Uri.parse(_landingUrl!)),
                      child: const Text('فتح الرابط'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: QrImageView(
                    data: _landingUrl!,
                    size: 200,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('شارك هذا الرابط مع صديقك ليحمل الملف مباشرة.'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}