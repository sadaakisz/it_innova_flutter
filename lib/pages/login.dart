import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:it_innova_flutter/pages/home.dart';
import 'package:it_innova_flutter/pages/recover_password.dart';
import 'package:it_innova_flutter/pages/register.dart';
import 'package:it_innova_flutter/services/login_service.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginService service = LoginService();

  //TODO: Remove function when auth is implemented
  void _enterMockValues() {
    setState(() {
      if (usernameController.text.isEmpty) {
        usernameController.text = 'Caceres@gmail.com';
        passwordController.text = '*Caceres123';
      } else {
        usernameController.clear();
        passwordController.clear();
      }
    });
  }

  void _showEmptyInputDialog() {
    oneOptionDialog(
      context: context,
      title: 'Existen campos vacíos',
      content: 'Por favor, completar todos los campos.',
    );
  }

  void _showIncorrectInputDialog() {
    oneOptionDialog(
      context: context,
      title: 'Datos Incorrectos',
      content: 'Usuario y/o Contraseña incorrectos.',
    );
  }

  void _showUnknownErrorDialog() {
    oneOptionDialog(
      context: context,
      title: 'Al parecer hubo un problema',
      content:
          'No pudimos completar su solicitud, intenta nuevamente en breves instantes.',
    );
  }

  void _login() async {
    String inputUsername = usernameController.text;
    String inputPassword = passwordController.text;

    String mockUsername = 'Caceres@gmail.com';
    String mockPassword = '*Caceres123';

    if (inputUsername.isEmpty || inputPassword.isEmpty) {
      _showEmptyInputDialog();
      return;
    }
    Response response =
        await service.login(email: inputUsername, password: inputPassword);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('patientId', service.patientId);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Home()),
      );
    } else if (response.statusCode == 400) {
      _showIncorrectInputDialog();
    } else {
      _showUnknownErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: 150,
                  //TODO: Remove GestureDetector when auth is implemented.
                  child: GestureDetector(
                    onTap: () => _enterMockValues(),
                    child: Image.asset('assets/ritmo_cardiaco.png'),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextFormField(
                      controller: usernameController,
                      decoration:
                          InputDecoration(hintText: 'Username or Email'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    GestureDetector(
                      //
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecoverPassword()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.cyan.shade100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _login(),
                        child: const Text('INGRESAR'),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(height: 1, color: Colors.black12)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('OR'),
                        ),
                        Expanded(
                            child: Container(height: 1, color: Colors.black12)),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()),
                          );
                        },
                        child: const Text('REGISTRARSE'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
