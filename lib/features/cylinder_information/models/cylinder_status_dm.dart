class CylinderStatusDm {
  bool success;
  String message;
  CylinderStatusDataDm? data;

  CylinderStatusDm({
    required this.success,
    required this.message,
    this.data,
  });

  factory CylinderStatusDm.fromJson(Map<String, dynamic> json) {
    return CylinderStatusDm(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? CylinderStatusDataDm.fromJson(json['data'])
          : null,
    );
  }
}

class CylinderStatusDataDm {
  String iname;
  String entryDate;
  String icode;
  String capacity;
  String batchNo;
  String dbc;
  String io;
  bool empty;
  String eunitQty;
  String eunit;
  String pcode;
  String invNo;
  String date;
  String pName;
  String batchDate;

  CylinderStatusDataDm({
    required this.iname,
    required this.entryDate,
    required this.icode,
    required this.capacity,
    required this.batchNo,
    required this.dbc,
    required this.io,
    required this.empty,
    required this.eunitQty,
    required this.eunit,
    required this.pcode,
    required this.invNo,
    required this.date,
    required this.pName,
    required this.batchDate,
  });

  factory CylinderStatusDataDm.fromJson(Map<String, dynamic> json) {
    return CylinderStatusDataDm(
      iname: json['INAME'] ?? '',
      entryDate: json['ENTRYDATE'] ?? '',
      icode: json['ICODE'] ?? ' ',
      capacity: json['CAPACITY'] ?? '',
      batchNo: json['BatchNo'] ?? '',
      dbc: json['DBC'] ?? '',
      io: json['IO'] ?? '',
      empty: json['empty'] == 'True',
      eunitQty: json['EunitQTY'] ?? '',
      eunit: json['Eunit'] ?? '',
      pcode: json['PCODE'] ?? '',
      invNo: json['INVNO'] ?? '',
      date: json['DATE'] ?? '',
      pName: json['PNAME'] ?? '',
      batchDate: json['BatchDate'] ?? '',
    );
  }
}
