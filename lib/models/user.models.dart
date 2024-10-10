class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.enroll,
    required this.school,
    required this.id,
    required this.isadmin,
  });
  late final String school;
  late final String id;
  late final String enroll;
  late final String name;
  late final String email;
  late final bool isadmin;

  UserModel.fromJson(Map<String, dynamic> json, bool isDB) {
    enroll = json['enroll'];
    // print(json['_id']);
    id = isDB ? json['_id'] : json['id'];
    // print(json['username']);
    name = json['name'];
    email = json['email'];
    school = json['school'];
    isadmin = json['isadmin'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['school'] = school;
    _data['email'] = email;
    _data['enroll'] = enroll;
    _data['isadmin'] = isadmin;
    return _data;
  }
}