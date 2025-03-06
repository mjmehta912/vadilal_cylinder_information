import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  required Color backgroundColor,
  required Color textColor,
  required IconData icon,
}) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    borderRadius: 15,
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.all(16),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    animationDuration: const Duration(milliseconds: 750),
    duration: const Duration(seconds: 4),
    overlayBlur: 5,
    // ignore: deprecated_member_use
    overlayColor: Colors.black.withOpacity(0.3),
    boxShadows: [
      BoxShadow(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
    titleText: Row(
      children: [
        Icon(icon, color: textColor, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    ),
    messageText: Text(
      message,
      style: GoogleFonts.poppins(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
