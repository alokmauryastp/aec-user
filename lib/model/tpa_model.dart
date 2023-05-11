// @dart=2.9
class TPAModel {
  int status;
  String msg;
  TPAData data;

  TPAModel({this.status, this.msg, this.data});

  TPAModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new TPAData.fromJson(json['data']) : null;
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

class TPAData {
  String termCondiion;
  String privacyPolicy;
  String aboutUs;

  TPAData({this.termCondiion, this.privacyPolicy, this.aboutUs});

  TPAData.fromJson(Map<String, dynamic> json) {
    termCondiion = json['TermCondiion'];
    privacyPolicy = json['PrivacyPolicy'];
    aboutUs = json['AboutUs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TermCondiion'] = this.termCondiion;
    data['PrivacyPolicy'] = this.privacyPolicy;
    data['AboutUs'] = this.aboutUs;
    return data;
  }
}
