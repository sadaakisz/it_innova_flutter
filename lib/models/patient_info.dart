class PatientInfo {
  PatientInfo({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
  });
  late final int id;
  late final String name;
  late final String lastName;
  late final String email;
  late final String password;

  PatientInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}
