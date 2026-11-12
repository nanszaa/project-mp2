import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPages extends StatefulWidget {
  const ScannerPages({super.key});

  @override
  State<ScannerPages> createState() => _ScannerPagesState();
}

class _ScannerPagesState extends State<ScannerPages> {
  // Controller untuk mengontrol kamera (misal: flash, switch camera)
  final MobileScannerController _scannerController = MobileScannerController();
  bool _isFlashOn = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Latar Belakang Kamera (Mobile Scanner)
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                // Ketika QR Code berhasil dibaca
                final String? code = barcode.rawValue;
                if (code != null) {
                  // Tampilkan hasil scan atau arahkan ke halaman beranda meja terkait
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Berhasil Scan Meja: $code')),
                  );
                  break;
                }
              }
            },
          ),

          // 2. Lapisan Transparan Gelap di atas kamera agar mirip desain Stitch
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // 3. Konten / Elemen UI di atas Kamera
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo / Brand Kohi
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.coffee, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text('Kohi Coffee', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // Status Kamera Aktif
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            const Text('KAMERA AKTIF', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // Tombol Bantuan (?)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: const Icon(Icons.help_outline, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Kotak Bingkai Pemindai (Scanner Finder Box)
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        // Garis laser animasi / hiasan tengah
                        Center(
                          child: Container(
                            width: 200,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDECD0),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFFFDECD0).withOpacity(0.8), blurRadius: 8, spreadRadius: 2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Badge Akses Cepat
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '⚡ AKSES CEPAT • TANPA LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Teks Sambutan
                  const Text(
                    'Selamat Datang di Kohi Coffee',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Scan barcode di meja Anda untuk mulai memesan langsung tanpa antre dan tanpa registrasi.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),

                  // Tombol Nyalakan Flashlight
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isFlashOn = !_isFlashOn;
                      });
                      await _scannerController.toggleTorch();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            _isFlashOn ? 'Matikan Flashlight' : 'Nyalakan Flashlight',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tombol Input Manual Nomor Meja
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi ketika tombol input manual diklik
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.keyboard_outlined, size: 18, color: Colors.black87),
                          SizedBox(width: 8),
                          Text('Input Manual Nomor Meja', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Catatan Kaki Bawah
                  const Text(
                    'Langsung pesan tanpa akun • QR Code tertera di plakat meja',
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}