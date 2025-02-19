class UserModel{
  String? name;
  String? mobile;
  String? password;
  String? testName;
  bool? isAdmin;

  UserModel({this.name, this.mobile, this.password, this.isAdmin,this.testName});

  static fromJson(Map<String, dynamic> json){
    return UserModel(
      name: json['name'],
      mobile: json['mobile'],
      password: json['password'],
      isAdmin: json['isAdmin'],
      testName: json['testName'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['isAdmin'] = this.isAdmin;
    data['testName'] = this.testName;
    return data;
  }
}