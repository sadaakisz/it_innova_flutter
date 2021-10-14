class LocationValue {
  LocationValue({
    required this.latitud,
    required this.longitud,
    required this.fecha,
  });
  late final String latitud;
  late final String longitud;
  late final String fecha;

  LocationValue.fromJson(Map<String, dynamic> json) {
    latitud = json['latitud'];
    longitud = json['longitud'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitud'] = latitud;
    _data['longitud'] = longitud;
    _data['fecha'] = fecha;
    return _data;
  }
}
