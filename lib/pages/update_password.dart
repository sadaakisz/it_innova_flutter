import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:it_innova_flutter/pages/login.dart';
import 'package:it_innova_flutter/services/reset_password_service.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();

  String get email => widget.email;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ResetPasswordService service = ResetPasswordService();

  void _showEmptyInputDialog() {
    oneOptionDialog(
      context: context,
      title: 'Existen campos vacíos',
      content: 'Por favor, completar todos los campos.',
    );
  }

  void _showUnmatchedPasswordsDialog() {
    oneOptionDialog(
      context: context,
      title: 'Contraseñas no coinciden',
      content:
          'La confirmación de la contraseña no coincide con la contraseña brindada.',
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

  void _showPasswordUpdated() {
    oneOptionDialog(
      context: context,
      title: 'Contraseña Actualizada',
      content: 'Su contraseña fue actualizada.',
      action: 'Aceptar',
      onDismiss: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
        );
      },
    );
  }

  void _updatePassword() async {
    String inputCode = codeController.text;
    String inputPassword = passwordController.text;
    String inputConfirmPassword = confirmPasswordController.text;

    if (inputCode.isEmpty ||
        inputPassword.isEmpty ||
        inputConfirmPassword.isEmpty) {
      _showEmptyInputDialog();
      return;
    }
    if (inputPassword != inputConfirmPassword) {
      _showUnmatchedPasswordsDialog();
      return;
    }
    bool validPass =
        RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}")
            .hasMatch(inputPassword);
    if (inputPassword.isEmpty || !validPass) {
      _showWeakPasswordDialog();
      return;
    }
    Response response = await service.resetPassword(
        email: email, token: inputCode, password: inputPassword);
    if (response.statusCode == 200) _showPasswordUpdated();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Actualizar contraseña',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Container(
            height: height * 0.6,
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextFormField(
                        controller: codeController,
                        decoration:
                            InputDecoration(labelText: 'Ingrese el código'),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: 'Nueva contraseña'),
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: 'Repetir Contraseña'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate())
                              _updatePassword();
                          },
                          child: const Text('Guardar contraseña'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
