import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' if (dart.library.html) 'dart:html';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String? _fromUser;
  String? _magnetUri;
  double _progress = 0.0;
  bool _isDownloading = false;
  String _downloadUrl = '';
  int _peers = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Parse query parameters from URL (placeholder for web navigation)
    final uri = Uri.base;
    _magnetUri = uri.queryParameters['magnet'];
    _fromUser = uri.queryParameters['from'] ?? 'غير معروف';
  }

  void _startDownload() {
    setState(() {
      _isDownloading = true;
    });
    // Placeholder for WebTorrent download logic
    // Simulate progress
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _progress = 0.5;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _progress = 1.0;
        _downloadUrl = 'blob:example'; // Placeholder blob URL
      });
    });
  }

  void _openInTorrent() {
    if (_magnetUri != null) {
      launchUrl(Uri.parse(_magnetUri!));
    }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('المستخدم $_fromUser أرسل لك ملفًا.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startDownload,
                child: const Text('تحميل مباشر عبر المتصفح (P2P)'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _openInTorrent,
                child: const Text('فتح في برنامج تورنت خارجي'),
              ),
              if (_isDownloading) ...[
                const SizedBox(height: 20),
                LinearProgressIndicator(value: _progress),
                Text('التقدم: ${(_progress * 100).toStringAsFixed(0)}%'),
                Text('عدد الـPeers: $_peers'),
              ],
              if (_progress == 1.0) ...[
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => launchUrl(Uri.parse(_downloadUrl)),
                  child: const Text('تحميل الآن'),
                ),
              ],
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: _magnetUri),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Magnet Link',
                ),
              ),
              const SizedBox(height: 10),
              const Text('احتفظ بالصفحة مفتوحة حتى يكتمل التحميل.'),
            ],
          ),
        ),
      ),
    );
  }
}