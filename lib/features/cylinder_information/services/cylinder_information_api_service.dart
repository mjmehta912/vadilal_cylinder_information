import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vadilal_cylinder_information/features/cylinder_information/models/cylinder_info_dm.dart';

class CylinderInformationApiService {
  static const String baseUrl = 'https://testcrm2.vadilalchemicals.in/api';

  static Future<CylinderInfoDm?> fetchCylinderDetail(
    String cylinderNo,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/CylinderEnquiry/CylinderDetail?cylinderNo=$cylinderNo',
      ),
    );

    if (response.statusCode == 200) {
      return CylinderInfoDm.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
}
