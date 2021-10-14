class Patient {
  Patient({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dni,
    required this.dateCreation,
    required this.dateLocation,
  });
  late final String name;
  late final String lastName;
  late final String email;
  late final String password;
  late final String dni;
  late final String dateCreation;
  late final String dateLocation;

  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    dni = json['dni'];
    dateCreation = json['dateCreation'];
    dateLocation = json['dateLocation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['password'] = password;
    _data['dni'] = dni;
    _data['dateCreation'] = dateCreation;
    _data['dateLocation'] = dateLocation;
    return _data;
  }
}
