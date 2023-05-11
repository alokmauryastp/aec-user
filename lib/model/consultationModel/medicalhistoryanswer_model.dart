// @dart=2.9
class MedicalHistoryAnswerModel {
  int status;
  String msg;
  MedicalHistoryAnswerData data;

  MedicalHistoryAnswerModel({this.status, this.msg, this.data});

  MedicalHistoryAnswerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new MedicalHistoryAnswerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MedicalHistoryAnswerData {
  int id;

  MedicalHistoryAnswerData({this.id});

  MedicalHistoryAnswerData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    return data;
  }
}
