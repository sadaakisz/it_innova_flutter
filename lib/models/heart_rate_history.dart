class HeartRateHistory {
  HeartRateHistory({required this.bpm, required this.date});
  late final int bpm;
  late final String date;

  HeartRateHistory.fromJson(Map<String, dynamic> json) {
    bpm = json['ritmoCardiaco'];
    date = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ritmoCardiaco'] = bpm;
    _data['fecha'] = date;
    return _data;
  }
}
