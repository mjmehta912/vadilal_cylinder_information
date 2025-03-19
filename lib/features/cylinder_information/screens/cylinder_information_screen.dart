import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/controllers/cylinder_information_controller.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/screens/qr_scanner_screen.dart';

class CylinderInformationScreen extends StatelessWidget {
  CylinderInformationScreen({
    super.key,
  });

  final CylinderInformationController _controller =
      Get.find<CylinderInformationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF141E30),
                  Color(0xFF243B55),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Cylinder Information Content
          Obx(
            () {
              if (_controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (_controller.cylinderInformation.value != null &&
                  _controller.cylinderStatus.value != null) {
                final cylinderInformation =
                    _controller.cylinderInformation.value!;

                final cylinderStatus = _controller.cylinderStatus.value!;
                final cylinderData = cylinderInformation.data;
                final cylinderStatusData = cylinderStatus.data;

                return cylinderData == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              cylinderInformation.message,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // ignore: deprecated_member_use
                                backgroundColor: Colors.white.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                elevation: 5,
                              ),
                              onPressed: () => Get.back(),
                              child: Icon(
                                Icons.qr_code_2,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 60),

                            // Header: Cylinder Number
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    // ignore: deprecated_member_use
                                    color: Colors.white.withOpacity(0.4)),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cylinder No : ${cylinderData.cylNo}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Rotation No : ${cylinderData.rtnNo}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // ignore: deprecated_member_use
                                      color: Colors.white.withOpacity(0.1),
                                      border: Border.all(
                                        // ignore: deprecated_member_use
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: constraints
                                                .maxHeight, // ✅ Ensures full visibility
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                buildInfoItem(
                                                    "Water Capacity",
                                                    cylinderData
                                                        .cylinderTypeName),
                                                buildInfoItem(
                                                    "Make Of Cylinder",
                                                    cylinderData.mnf),
                                                buildInfoItem('Valve',
                                                    cylinderData.valve),
                                                buildInfoItem('Valve Make',
                                                    cylinderData.make),
                                                buildInfoItem(
                                                    "HydroTesting Date",
                                                    cylinderData.hDDate),
                                                buildInfoItem(
                                                    "Next HydroTesting Date",
                                                    cylinderData.nxtHDtstingDt),
                                                buildInfoItem(
                                                    "Group", cylinderData.gas),
                                                buildInfoItem("Gas Service",
                                                    cylinderData.iName),
                                                buildInfoItem(
                                                  "Batch No.",
                                                  cylinderStatusData!.batchNo,
                                                ),
                                                buildInfoItem(
                                                  "Batch Date.",
                                                  cylinderStatusData.batchDate,
                                                ),
                                                buildInfoItem(
                                                  "Volume Of Gas",
                                                  '${cylinderStatusData.eunitQty} ${cylinderStatusData.eunit}',
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            // Neumorphic Styled Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // ignore: deprecated_member_use
                                backgroundColor: Colors.white.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                elevation: 5,
                              ),
                              onPressed: () {
                                Get.offUntil(
                                  GetPageRoute(page: () => QrScannerScreen()),
                                  (route) => false,
                                );
                              },
                              child: Icon(
                                Icons.qr_code_2,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      );
              } else {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No data found.',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          backgroundColor: Colors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          elevation: 5,
                        ),
                        onPressed: () => Get.back(),
                        child: Icon(
                          Icons.qr_code_2,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildInfoItem(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$title ",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value != null && value.toString().trim().isNotEmpty
                  ? value.toString()
                  : "N/A",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
