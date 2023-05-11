// @dart=2.9
class FindDoctors {
  int status;
  String msg;
  List<FindDoctorsData> data;

  FindDoctors({this.status, this.msg, this.data});

  FindDoctors.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<FindDoctorsData>();
      json['data'].forEach((v) {
        data.add(new FindDoctorsData.fromJson(v));
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

class FindDoctorsData {
  String doctorId;
  String name;
  String disease;
  double rating;
  String experiance;
  String profile;
  String is_consult;
  String is_online;

  FindDoctorsData(
      {this.doctorId,
        this.name,
        this.disease,
        this.rating,
        this.experiance,
        this.profile,
        this.is_consult,
        this.is_online
      });

  FindDoctorsData.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    name = json['Name'];
    disease = json['Disease'];
    rating = json['Rating'].toDouble();
    experiance = json['Experiance'];
    profile = json['Profile'];
    is_consult = json['is_consult'].toString();
    is_online = json['is_online'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['Name'] = this.name;
    data['Disease'] = this.disease;
    data['Rating'] = this.rating;
    data['Experiance'] = this.experiance;
    data['Profile'] = this.profile;
    data['is_consult'] = this.is_consult;
    data['is_online'] = this.is_online;
    return data;
  }
}
