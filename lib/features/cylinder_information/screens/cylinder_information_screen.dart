import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/controllers/cylinder_information_controller.dart';

class CylinderInformationScreen extends StatelessWidget {
  CylinderInformationScreen({super.key});

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
              } else if (_controller.cylinderInformation.value != null) {
                final cylinderInformation =
                    _controller.cylinderInformation.value!;
                final cylinderData = cylinderInformation.data;

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
                                Icons.arrow_back,
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
                                  vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Cylinder No: ${cylinderData.cylNo}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Floating Glass Card with Data
                            Expanded(
                              child: SingleChildScrollView(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15, sigmaY: 15),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        // ignore: deprecated_member_use
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border.all(
                                            // ignore: deprecated_member_use
                                            color:
                                                Colors.white.withOpacity(0.3)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildInfoItem(
                                              "Return No", cylinderData.rtnNo),
                                          buildInfoItem(
                                              "Manufacturer", cylinderData.mnf),
                                          buildInfoItem(
                                              "Gas Type", cylinderData.gas),
                                          buildInfoItem("Tare Weight",
                                              cylinderData.tareWeight),
                                          buildInfoItem(
                                              "HD Date", cylinderData.hDDate),
                                          buildInfoItem("Is Imported",
                                              cylinderData.isImported),
                                          buildInfoItem(
                                              "Owner", cylinderData.owner),
                                          buildInfoItem("Heat Date",
                                              cylinderData.heatDate),
                                          buildInfoItem("Paint Date",
                                              cylinderData.paintdate),
                                          buildInfoItem("Next Testing Date",
                                              cylinderData.nxtHDtstingDt),
                                          buildInfoItem(
                                              "Item Name", cylinderData.iName),
                                          buildInfoItem(
                                              "Make", cylinderData.make),
                                          buildInfoItem(
                                              "Batch No", cylinderData.batchNo),
                                          buildInfoItem("Specification No",
                                              cylinderData.specificationNo),
                                          buildInfoItem("Certificate No",
                                              cylinderData.certificateNo),
                                          buildInfoItem("Certificate Date",
                                              cylinderData.certificateDate),
                                          buildInfoItem(
                                              "Bill No", cylinderData.billNo),
                                          buildInfoItem("Bill Date",
                                              cylinderData.billDate),
                                          buildInfoItem("Supplier Name",
                                              cylinderData.suppName),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

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
                              onPressed: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),

                            const SizedBox(height: 40),
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
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          elevation: 5,
                        ),
                        onPressed: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back,
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
              "$title: ",
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
