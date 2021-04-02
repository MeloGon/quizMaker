import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/signup.dart';
import 'package:quizmaker_app/src/services/database.dart';
import 'package:quizmaker_app/src/widgets/card_bg.dart';
import 'package:quizmaker_app/src/widgets/widgets.dart';

import '../services/auth.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password, userId;
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  // signIn() async {
  //   if (_formKey.currentState.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService.signInEmailAndPass(email, password).then((value) {
  //       if (value != null) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => Home(userId)));
  //       }
  //     });
  //   }
  // }

  signIn(String email, String password) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      var resp = await databaseService.getUser(email, password);
      userId = await databaseService.getIdUser(email, password);
      print(userId);
      if (resp) {
        setState(() {
          _isLoading = false;
        });
        toast('Credenciales validados correctamente', Colors.blue[200],
            Colors.white, 14);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home(userId)));
      } else {
        toast('Credenciales invalidos', Colors.red[200], Colors.white, 14);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: pi / 15,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff00BFA6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        width: width * 0.78,
                        height: height * 0.43,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.85,
                          height: height * 0.43,
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 10,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: 30, left: 30, top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Correo :'),
                                  SizedBox(height: 6.0),
                                  TextFormField(
                                    validator: (value) {
                                      return value.isEmpty
                                          ? "Ingrese un Usuario correcto"
                                          : null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      fillColor:
                                          Color(0xffAAAAAA).withOpacity(0.29),
                                      filled: true,
                                      hintText: "example@example.com",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (value) {
                                      email = value;
                                    },
                                  ),
                                  SizedBox(height: 10.0),
                                  Text('Contrasena :'),
                                  SizedBox(height: 6.0),
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      return value.isEmpty
                                          ? "Ingrese la contraseña correcta"
                                          : null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      fillColor:
                                          Color(0xffAAAAAA).withOpacity(0.29),
                                      filled: true,
                                      hintText: "**********",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (value) {
                                      password = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                      Text('Recordar Contrasena')
                                    ],
                                  ),
                                  Container(
                                    width: width,
                                    child: FloatingActionButton(
                                      backgroundColor: Color(0xff00BFA6),
                                      onPressed: () {
                                        signIn(email, password);
                                      },
                                      child: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 55,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Olvidaste tu contrasena "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Pulsa aqui",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff00BFA6)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No tienes una cuenta aun ? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Registrarse",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff00BFA6)),
                                ),
                              )
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
