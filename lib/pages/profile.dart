import 'package:flutter/material.dart';
import 'package:it_innova_flutter/pages/login.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';
import 'package:it_innova_flutter/widgets/two_options_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextStyle labelStyle = TextStyle(color: Colors.blueGrey.shade400);

  @override
  void initState() {
    //TODO: Get profile info from server
    nameController.text = 'Mario Raúl';
    surnameController.text = 'Caceres Calderon';
    passwordController.text = '*Caceres123';
    emailController.text = 'Caceres@gmail.com';
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

    //TODO: Update password
  }

  void _logout() {
    //TODO: Remove token from SharedPrefs.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => Login()),
    );
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
              //TODO: Show sign out dialog
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
