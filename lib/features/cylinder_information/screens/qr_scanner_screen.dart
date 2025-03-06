import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/controllers/cylinder_information_controller.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/screens/cylinder_information_screen.dart';

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

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;

    qrController?.scannedDataStream.listen(
      (scanData) {
        qrController?.pauseCamera();

        _controller.fetchCylinderData(scanData.code!).then(
          (_) async {
            // ignore: unused_local_variable
            final result = await Get.to(
              () => CylinderInformationScreen(),
            );

            if (qrController != null) {
              qrController!.resumeCamera();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
