import 'package:flutter/material.dart';
import 'package:it_innova_flutter/pages/login.dart';
import 'package:it_innova_flutter/widgets/two_options_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  void _logout() {
    //TODO: Remove token from SharedPrefs.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.black87),
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
                        onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
