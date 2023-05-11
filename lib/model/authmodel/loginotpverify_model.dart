// @dart=2.9
class LoginOtpVerifyModel {
  int status;
  String msg;
  LoginOtpVerifyData data;

  LoginOtpVerifyModel({this.status, this.msg, this.data});

  LoginOtpVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new LoginOtpVerifyData.fromJson(json['data']) : null;
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

class LoginOtpVerifyData {
  String userId;
  String name;
  String mobile;
  String email;
  String profile;
  String gender;
  String bloodGroup;
  String marritalStatus;
  String height;
  String weight;
  String alternetContact;
  String smoking;
  String alcohal;
  String activityLevel;
  String foodPrefrence;
  String occupation;
  String allergies;
  String currentMedication;
  String pastMedication;
  String injuries;
  String surguries;
  String chronicDiseases;
  String address;

  LoginOtpVerifyData(
      {this.userId,
        this.name,
        this.mobile,
        this.email,
        this.profile,
        this.gender,
        this.bloodGroup,
        this.marritalStatus,
        this.height,
        this.weight,
        this.alternetContact,
        this.smoking,
        this.alcohal,
        this.activityLevel,
        this.foodPrefrence,
        this.occupation,
        this.allergies,
        this.currentMedication,
        this.pastMedication,
        this.injuries,
        this.surguries,
        this.chronicDiseases,
        this.address});

  LoginOtpVerifyData.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    name = json['Name'];
    mobile = json['Mobile'];
    email = json['Email'];
    profile = json['Profile'];
    gender = json['Gender'];
    bloodGroup = json['BloodGroup'];
    marritalStatus = json['MarritalStatus'];
    height = json['Height'];
    weight = json['Weight'];
    alternetContact = json['AlternetContact'];
    smoking = json['Smoking'];
    alcohal = json['Alcohal'];
    activityLevel = json['ActivityLevel'];
    foodPrefrence = json['FoodPrefrence'];
    occupation = json['Occupation'];
    allergies = json['Allergies'];
    currentMedication = json['CurrentMedication'];
    pastMedication = json['PastMedication'];
    injuries = json['Injuries'];
    surguries = json['Surguries'];
    chronicDiseases = json['ChronicDiseases'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['Name'] = this.name;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['Profile'] = this.profile;
    data['Gender'] = this.gender;
    data['BloodGroup'] = this.bloodGroup;
    data['MarritalStatus'] = this.marritalStatus;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['AlternetContact'] = this.alternetContact;
    data['Smoking'] = this.smoking;
    data['Alcohal'] = this.alcohal;
    data['ActivityLevel'] = this.activityLevel;
    data['FoodPrefrence'] = this.foodPrefrence;
    data['Occupation'] = this.occupation;
    data['Allergies'] = this.allergies;
    data['CurrentMedication'] = this.currentMedication;
    data['PastMedication'] = this.pastMedication;
    data['Injuries'] = this.injuries;
    data['Surguries'] = this.surguries;
    data['ChronicDiseases'] = this.chronicDiseases;
    data['Address'] = this.address;
    return data;
  }
}
