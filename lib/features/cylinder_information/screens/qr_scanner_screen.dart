import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/controllers/cylinder_information_controller.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/screens/cylinder_information_screen.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/widgets/custom_snackbar.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({
    super.key,
  });

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final CylinderInformationController _controller = Get.put(
    CylinderInformationController(),
  );
  final GlobalKey qrKey = GlobalKey(
    debugLabel: 'QR',
  );
  QRViewController? qrController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        qrController?.resumeCamera();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned.fill(
            child: Container(
              color: Color(0x80000000),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Align QR code within the frame",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isProcessing = false;

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;

    qrController?.scannedDataStream.listen(
      (scanData) async {
        if (isProcessing) return;

        isProcessing = true;
        qrController?.pauseCamera();

        String scanDataCode = scanData.code ?? '';

        final regex1 = RegExp(r'Cylinder No\s*:\s*(\d+)');
        final regex2 = RegExp(r'Cyl No\.\s*-\s*(\d+)');
        final regex3 = RegExp(r'^\d+$');

        String? cylinderNo;
        if (regex1.hasMatch(scanDataCode)) {
          cylinderNo = regex1.firstMatch(scanDataCode)?.group(1);
        } else if (regex2.hasMatch(scanDataCode)) {
          cylinderNo = regex2.firstMatch(scanDataCode)?.group(1);
        } else if (regex3.hasMatch(scanDataCode)) {
          cylinderNo = scanDataCode;
        }

        if (cylinderNo == null) {
          showCustomSnackbar(
            title: "Invalid QR Code",
            message: "The scanned QR code format is incorrect.",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            icon: Icons.error,
          );
          isProcessing = false;
          qrController?.resumeCamera();
          return;
        }

        Get.dialog(
          Center(child: CircularProgressIndicator(color: Colors.white)),
          barrierDismissible: false,
        );

        try {
          await Future.wait([
            _controller.fetchCylinderData(cylinderNo),
            _controller.fetchCylinderStatus(cylinderNo),
          ]);

          Get.back();

          await Get.offAll(
            () => CylinderInformationScreen(),
          );
        } catch (e) {
          Get.back();
          showCustomSnackbar(
            title: "Error",
            message: e.toString(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
            icon: Icons.error,
          );
        } finally {
          isProcessing = false;
          qrController?.resumeCamera();
        }
      },
    );
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
