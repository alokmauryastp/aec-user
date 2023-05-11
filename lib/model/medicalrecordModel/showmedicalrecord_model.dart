// @dart=2.9
class ShowMedicalRecordModel {
  int status;
  String msg;
  List<ShowMedicalRecordData> data;

  ShowMedicalRecordModel({this.status, this.msg, this.data});

  ShowMedicalRecordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ShowMedicalRecordData>();
      json['data'].forEach((v) {
        data.add(new ShowMedicalRecordData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowMedicalRecordData {
  String medicalReportId;
  String disease;
  String description;
  String medicalReport;
  String date;
  String time;

  ShowMedicalRecordData(
      {this.medicalReportId,
        this.disease,
        this.description,
        this.medicalReport,
        this.date,
        this.time});

  ShowMedicalRecordData.fromJson(Map<String, dynamic> json) {
    medicalReportId = json['MedicalReportId'];
    disease = json['Disease'];
    description = json['Description'];
    medicalReport = json['MedicalReport'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicalReportId'] = this.medicalReportId;
    data['Disease'] = this.disease;
    data['Description'] = this.description;
    data['MedicalReport'] = this.medicalReport;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
