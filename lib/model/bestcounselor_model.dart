// @dart=2.9
class BestCounselorModel {
  int status;
  String msg;
  List<BestCounselorData> data;

  BestCounselorModel({this.status, this.msg, this.data});

  BestCounselorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<BestCounselorData>();
      json['data'].forEach((v) {
        data.add(new BestCounselorData.fromJson(v));
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

class BestCounselorData {
  String doctorId;
  String name;
  double rating;
  String experiance;
  String profile;
  String speciality;

  BestCounselorData(
      {this.doctorId,
        this.name,
        this.rating,
        this.experiance,
        this.profile,
        this.speciality});

  BestCounselorData.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    name = json['Name'];
    rating = json['Rating'].toDouble();
    experiance = json['Experiance'];
    profile = json['Profile'];
    speciality = json['Speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['Name'] = this.name;
    data['Rating'] = this.rating;
    data['Experiance'] = this.experiance;
    data['Profile'] = this.profile;
    data['Speciality'] = this.speciality;
    return data;
  }
}
