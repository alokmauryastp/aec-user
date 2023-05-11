// @dart=2.9
class SpecialityModel {
  int status;
  String msg;
  List<SpecialityData> data;

  SpecialityModel({this.status, this.msg, this.data});

  SpecialityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SpecialityData>();
      json['data'].forEach((v) {
        data.add(new SpecialityData.fromJson(v));
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

class SpecialityData {
  String doctorSpecialityId;
  String speciality;
  String price;
  String image;

  SpecialityData({this.doctorSpecialityId, this.speciality, this.price, this.image});

  SpecialityData.fromJson(Map<String, dynamic> json) {
    doctorSpecialityId = json['DoctorSpecialityId'];
    speciality = json['Speciality'];
    price = json['Price'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorSpecialityId'] = this.doctorSpecialityId;
    data['Speciality'] = this.speciality;
    data['Price'] = this.price;
    data['Image'] = this.image;
    return data;
  }
}
