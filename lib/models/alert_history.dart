class AlertHistory {
  AlertHistory({
    required this.id,
    required this.heartRate,
    required this.name,
    required this.date,
  });
  late int id;
  late int heartRate;
  late String name;
  late String date;

  AlertHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heartRate = json['heartRate'];
    name = json['transtorno'];
    date = json['fecha_ritmo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['heartRate'] = heartRate;
    _data['transtorno'] = name;
    _data['fecha_ritmo'] = date;
    return _data;
  }
}
