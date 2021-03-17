import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/signup.dart';
import 'package:quizmaker_app/src/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? "Ingrese un Usuario correcto" : null;
                },
                decoration: InputDecoration(
                  hintText: "Usuario",
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 6.0),
              TextFormField(
                validator: (value) {
                  return value.isEmpty
                      ? "Ingrese la contraseña correcta"
                      : null;
                },
                decoration: InputDecoration(
                  hintText: "Contraseña",
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 14,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Sign In')),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No tienes una cuenta aun ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Registrarse",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
