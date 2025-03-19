class CylinderInfoDm {
  bool success;
  String message;
  CylinderDataDm? data; // Nullable data

  CylinderInfoDm({
    required this.success,
    required this.message,
    this.data,
  });

  factory CylinderInfoDm.fromJson(Map<String, dynamic> json) {
    return CylinderInfoDm(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? CylinderDataDm.fromJson(json['data']) : null,
    );
  }
}

class CylinderDataDm {
  String cylNo;
  String rtnNo;
  String mnf;
  String gas;
  String cylinderTypeName;
  String tareWeight;
  String hDDate;
  String isImported;
  String owner;
  String heatDate;
  String paintdate;
  String nxtHDtstingDt;
  String iName;
  String make;
  String batchNo;
  String specificationNo;
  String certificateNo;
  String certificateDate;
  String billNo;
  String billDate;
  String suppName;
  String valve;

  CylinderDataDm({
    required this.cylNo,
    required this.rtnNo,
    required this.mnf,
    required this.gas,
    required this.cylinderTypeName,
    required this.tareWeight,
    required this.hDDate,
    required this.isImported,
    required this.owner,
    required this.heatDate,
    required this.paintdate,
    required this.nxtHDtstingDt,
    required this.iName,
    required this.make,
    required this.batchNo,
    required this.specificationNo,
    required this.certificateNo,
    required this.certificateDate,
    required this.billNo,
    required this.billDate,
    required this.suppName,
    required this.valve,
  });

  factory CylinderDataDm.fromJson(Map<String, dynamic> json) {
    return CylinderDataDm(
      cylNo: json['CylNo'] ?? '',
      rtnNo: json['RtnNo'] ?? '',
      mnf: json['mnf'] ?? '',
      gas: json['gas'] ?? '',
      cylinderTypeName: json['CylinderTypeName'] ?? '',
      tareWeight: json['TareWeight'] ?? '',
      hDDate: json['HDDate'] ?? '',
      isImported: json['isImported'] ?? '',
      owner: json['Owner'] ?? '',
      heatDate: json['HeatDate'] ?? '',
      paintdate: json['Paintdate'] ?? '',
      nxtHDtstingDt: json['nxtHDtstingDt'] ?? '',
      iName: json['INAME'] ?? '',
      make: json['Make'] ?? '',
      batchNo: json['BatchNo'] ?? '',
      specificationNo: json['SpecificationNo'] ?? '',
      certificateNo: json['CertificateNo'] ?? '',
      certificateDate: json['CertificateDate'] ?? '',
      billNo: json['BillNo'] ?? '',
      billDate: json['BillDate'] ?? '',
      suppName: json['SuppName'] ?? '',
      valve: json['Valve'] ?? '',
    );
  }
}
