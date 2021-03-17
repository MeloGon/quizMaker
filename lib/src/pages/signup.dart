import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/signin.dart';
import 'package:quizmaker_app/src/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
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
                  hintText: "Nombre",
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 6.0),
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text('Sign In')),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ya tienes una cuenta creada ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      "Ingresa",
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
