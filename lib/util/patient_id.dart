import 'package:shared_preferences/shared_preferences.dart';

class PatientId {
  Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('patientId');
    if (id != null)
      return id;
    else
      return 0;
  }
}
