class UserData {
  bool? isValid;
  Data? data;
  String? token;

  UserData({this.isValid, this.data, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    isValid = json['is_valid'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_valid'] = this.isValid;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? password;
  String? email;
  String? emailVerifiedAt;
  String? role;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.username,
      this.password,
      this.email,
      this.emailVerifiedAt,
      this.role,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
