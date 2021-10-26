import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:it_innova_flutter/pages/update_password.dart';
import 'package:it_innova_flutter/services/send_email_service.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  SendEmailService service = SendEmailService();

  //TODO: Remove function when auth is implemented
  void _enterMockValues() {
    setState(() {
      if (emailController.text.isEmpty) {
        emailController.text = 'Caceres@gmail.com';
      } else {
        emailController.clear();
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

  void _showIncorrectEmailDialog() {
    oneOptionDialog(
      context: context,
      title: 'Correo Inválido',
      content: 'El correo ingresado no se encuentra registrado.',
    );
  }

  void _showRecoveryEmailSent() {
    oneOptionDialog(
      context: context,
      title: 'Código Enviado',
      content: 'Se ha enviado un código al correo enviado.',
      action: 'Aceptar',
      onDismiss: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => UpdatePassword(
                    email: emailController.text,
                  )),
        );
      },
    );
  }

  void _sendRecoveryEmail() async {
    String inputEmail = emailController.text;

    if (inputEmail.isEmpty) {
      _showEmptyInputDialog();
      return;
    }
    Response response = await service.sendEmail(email: inputEmail);
    if (response.statusCode == 200) _showRecoveryEmailSent();
    /*else {
      _showIncorrectEmailDialog();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _enterMockValues(),
          child: Text(
            'Recuperar contraseña',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              height: height * 0.3,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Ingrese su correo electrónico'),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => _sendRecoveryEmail(),
                            child: const Text('Enviar correo de recuperación'),
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
      ),
    );
  }
}
