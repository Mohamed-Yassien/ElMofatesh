class LoginModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  User? user;
  List<String>? permissions;

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    permissions = json['permissions'].cast<String>();
  }
}

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? mobile;
  String? password;
  String? isActive;
  String? roleId;
  String? nationality;
  String? createdAt;
  String? updatedAt;
  Null? company;


  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    isActive = json['is_active'];
    roleId = json['role_id'];
    nationality = json['nationality'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company = json['company'];
  }
}
