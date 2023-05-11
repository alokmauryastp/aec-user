class Data {
  Data({
       this.district,});

  Data.fromJson(dynamic json) {
    district = json['district'];
  }
  String? district;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = district;
    return map;
  }

}