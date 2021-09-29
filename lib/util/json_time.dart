import 'package:intl/intl.dart';

class JsonTime {
  getJsonTime() {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    return dateFormat.format(DateTime.now()) + '.000+00:00';
  }

  getJsonDate() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(DateTime.now());
  }
}
