// @dart=2.9
class ReConsultModel {
  int status;
  String msg;
  ReConsultData data;

  ReConsultModel({this.status, this.msg, this.data});

  ReConsultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new ReConsultData.fromJson(json['data']) : null;
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

class ReConsultData {
  int counsultId;
  int consultAmount;
  ReConsultData({this.counsultId, this.consultAmount});
  ReConsultData.fromJson(Map<String, dynamic> json) {
    counsultId = json['CounsultId'];
    consultAmount = json['ConsultAmount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CounsultId'] = this.counsultId;
    data['ConsultAmount'] = this.consultAmount;
    return data;
  }
}
