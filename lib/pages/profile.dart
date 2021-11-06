import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/patient_info.dart';
import 'package:it_innova_flutter/pages/login.dart';
import 'package:it_innova_flutter/services/patient_info_service.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';
import 'package:it_innova_flutter/widgets/two_options_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  int patientId = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextStyle labelStyle = TextStyle(color: Colors.blueGrey.shade400);

  PatientInfoService service = PatientInfoService();

  getProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    patientId = prefs.getInt('patientId')!;
    nameController.text = prefs.getString('patientName')!;
    surnameController.text = prefs.getString('patientLastName')!;
    passwordController.text = prefs.getString('patientPassword')!;
    emailController.text = prefs.getString('patientEmail')!;
  }

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  void _showEmptyInputDialog() {
    oneOptionDialog(
      context: context,
      title: 'Existen campos vacíos',
      content: 'Por favor, completar todos los campos.',
    );
  }

  void _showWeakPasswordDialog() {
    oneOptionDialog(
      context: context,
      title: 'Contraseña débil',
      content:
          'Usa 8 o más caracteres con una combinación de\nletras mayúsculas y mínusculas, números y símbolos.',
    );
  }

  void _showProfileUpdated() {
    oneOptionDialog(
      context: context,
      title: 'Perfil actualizado',
      content: 'El perfil ha sido actualizado de manera correcta.',
      action: 'Aceptar',
    );
  }

  void _updateProfile() async {
    String inputName = nameController.text;
    String inputSurname = surnameController.text;
    String inputEmail = emailController.text;
    String inputPassword = passwordController.text;

    if (inputName.isEmpty ||
        inputSurname.isEmpty ||
        inputEmail.isEmpty ||
        inputPassword.isEmpty) {
      _showEmptyInputDialog();
      return;
    }
    bool validPass =
        RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}")
            .hasMatch(inputPassword);
    if (inputPassword.isEmpty || !validPass) {
      _showWeakPasswordDialog();
      return;
    }
    PatientInfo patientInfo = PatientInfo(
        id: patientId,
        name: inputName,
        lastName: inputSurname,
        email: inputEmail,
        password: inputPassword);
    service.patientInfo = patientInfo;
    service.modifyData();
    _showProfileUpdated();
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('patientId');
    await prefs.remove('patientName');
    await prefs.remove('patientLastName');
    await prefs.remove('patientEmail');
    await prefs.remove('patientPassword');
    pushNewScreen(context, screen: Login(), withNavBar: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Mi Perfil',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        actions: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () => twoOptionsDialog(
                  context: context,
                  title: '¿Desea salir de la aplicación?',
                  action: _logout),
              child: Container(
                color: Colors.cyan.shade100,
                alignment: Alignment.center,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: SizedBox(
                  width: 150,
                  child: Image.asset('assets/perfil.png'),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombres:',
                        labelStyle: labelStyle,
                      ),
                    ),
                    TextFormField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        labelText: 'Apellidos:',
                        labelStyle: labelStyle,
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña:',
                        labelStyle: labelStyle,
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo:',
                        labelStyle: labelStyle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          //TODO: Implement form submission
                          onPressed: () {
                            if (_formKey.currentState!.validate())
                              _updateProfile();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8.0),
                            child: Text('Guardar'),
                          ),
                        ),
                        ElevatedButton(
                          //TODO: Implement form dismiss (revert)
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8.0),
                            child: Text('Cancelar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
