import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/models/cylinder_info_dm.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/services/cylinder_information_api_service.dart';
import 'package:vadilal_cylinder_information/features/cylinder_information/widgets/custom_snackbar.dart';

class CylinderInformationController extends GetxController {
  var cylinderInformation = Rx<CylinderInfoDm?>(null);
  var isLoading = false.obs;
  var _snackbarShown = false;
  Future<void> fetchCylinderData(String cylinderNo) async {
    isLoading(true);
    _snackbarShown = false;

    try {
      final fetchedData =
          await CylinderInformationApiService.fetchCylinderDetail(cylinderNo);

      if (fetchedData != null) {
        cylinderInformation.value = fetchedData;

        if (fetchedData.data == null && !_snackbarShown) {
          _snackbarShown = true;
          showCustomSnackbar(
            title: 'Alert!',
            message: fetchedData.message,
            // ignore: deprecated_member_use
            backgroundColor: Colors.amber.withOpacity(0.2),
            textColor: Colors.white,
            icon: Icons.warning_amber_rounded,
          );
        }
      } else if (!_snackbarShown) {
        _snackbarShown = true;
        showCustomSnackbar(
          title: 'Error',
          message: 'Error fetching data from server.',
          // ignore: deprecated_member_use
          backgroundColor: Colors.red.withOpacity(0.2),
          textColor: Colors.white,
          icon: Icons.error_outline,
        );
      }
    } catch (e) {
      if (!_snackbarShown) {
        _snackbarShown = true;
        showCustomSnackbar(
          title: 'Error',
          message: e.toString(),
          // ignore: deprecated_member_use
          backgroundColor: Colors.red.withOpacity(0.2),
          textColor: Colors.white,
          icon: Icons.error_outline,
        );
      }
    } finally {
      isLoading(false);
    }
  }
}
