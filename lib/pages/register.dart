import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:it_innova_flutter/models/patient.dart';
import 'package:it_innova_flutter/services/patient_service.dart';
import 'package:it_innova_flutter/util/json_time.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  PatientService service = new PatientService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //TODO: Remove function when auth is implemented
  void _enterMockValues() {
    setState(() {
      if (nameController.text.isEmpty) {
        nameController.text = 'Mario';
        surnameController.text = 'Caceres';
        emailController.text = 'Caceres@gmail.com';
        dniController.text = '87654321';
        passwordController.text = '*Caceres123';
        confirmPasswordController.text = '*Caceres123';
      } else {
        nameController.clear();
        surnameController.clear();
        emailController.clear();
        dniController.clear();
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

  void _showAlreadyRegisteredDialog() {
    oneOptionDialog(
      context: context,
      title: 'Registro Erroneo',
      content: 'El campo ingresado ya se encuentra registado con otra cuenta.',
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

  void _register() async {
    String inputName = nameController.text;
    String inputSurname = surnameController.text;
    String inputEmail = emailController.text;
    String inputDni = dniController.text;
    String inputPassword = passwordController.text;
    String inputConfirmPassword = confirmPasswordController.text;

    String mockRegisteredEmail =
        'Caceres@gmail.com'; // Would be managed by the request status

    if (inputName.isEmpty ||
        inputSurname.isEmpty ||
        inputEmail.isEmpty ||
        inputDni.isEmpty ||
        inputPassword.isEmpty ||
        inputConfirmPassword.isEmpty) {
      _showEmptyInputDialog();
      return;
    }
    if (inputPassword != inputConfirmPassword) {
      _showUnmatchedPasswordsDialog();
      return;
    }
    String now = JsonTime().getJsonTime();
    Patient patient = new Patient(
        name: inputName,
        lastName: inputSurname,
        email: inputEmail,
        password: inputPassword,
        dni: inputDni,
        dateCreation: now,
        dateLocation: now);
    service.patient = patient;
    //TODO: Handle non 200 status code
    Response response = await service.createData();
    if (response.statusCode == 200) {
      print('Registered!');
      Navigator.of(context).pop();
    } else {
      _showUnknownErrorDialog();
    }
    //TODO: Already registered accounts is not handled in backend
    /*else {
      _showAlreadyRegisteredDialog();
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
            'Registro',
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
                        controller: nameController,
                        decoration: InputDecoration(hintText: 'Nombres'),
                      ),
                      TextFormField(
                        controller: surnameController,
                        decoration: InputDecoration(hintText: 'Apellidos'),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: 'Correo'),
                      ),
                      TextFormField(
                        controller: dniController,
                        decoration: InputDecoration(hintText: 'DNI'),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Contraseña'),
                        validator: (value) {
                          bool validPass = RegExp(
                                  "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}")
                              .hasMatch(value!);
                          if (value.isEmpty || !validPass) {
                            return 'Usa 8 o más caracteres con una combinación de\nletras mayúsculas y mínusculas, números y símbolos.';
                          }
                        },
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration:
                            InputDecoration(hintText: 'Confirmar Contraseña'),
                        validator: (value) {
                          bool validPass = RegExp(
                                  "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}")
                              .hasMatch(value!);
                          if (value.isEmpty || !validPass) {
                            return 'Usa 8 o más caracteres con una combinación de\nletras mayúsculas y mínusculas, números y símbolos.';
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) _register();
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
      ),
    );
  }
}
