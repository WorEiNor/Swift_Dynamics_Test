class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? province;
  int? provinceId;
  String? idCardNo;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.province,
      this.provinceId,
      this.idCardNo});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNo = json['phoneNo'];
    province = json['province'];
    provinceId = json['province_id'];
    idCardNo = json['id_card_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phoneNo'] = this.phoneNo;
    data['province'] = this.province;
    data['province_id'] = this.provinceId;
    data['id_card_no'] = this.idCardNo;
    return data;
  }
}
