import 'package:flutter/material.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //TODO: Remove function when auth is implemented
  void _enterMockValues() {
    setState(() {
      if (emailController.text.isEmpty) {
        emailController.text = '123498';
        passwordController.text = '*Caceres123';
        confirmPasswordController.text = '*Caceres123';
      } else {
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
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

  void _updatePassword() {
    String inputEmail = emailController.text;
    String inputPassword = passwordController.text;
    String inputConfirmPassword = confirmPasswordController.text;

    if (inputEmail.isEmpty ||
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
    //TODO: Show dialog Contraseña actualizada
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _enterMockValues(),
          child: Text(
            'Actualizar contraseña',
            style: TextStyle(color: Colors.black87),
          ),
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
                        controller: emailController,
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
