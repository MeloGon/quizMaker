import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quizmaker_app/src/pages/signin.dart';
import 'package:quizmaker_app/src/services/database.dart';
import 'package:quizmaker_app/src/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

import '../services/auth.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password, userId;
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      userId = randomAlphaNumeric(16);
      Map<String, String> userMap = {
        "password": password,
        "type": "alumno",
        "user": email,
        "userId": userId,
        "username": name,
      };
      await databaseService.createUser(userMap, userId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home(userId)));
        });
      });
    }
  }

  //this kind of sifn up is if we work with firebase authentication
  // signUp() async {
  //   if (_formKey.currentState.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService.signUpWithEmailAndPass(email, password).then((value) {
  //       if (value != null) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => Home()));
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: width,
            height: height,
            child: Column(
              children: [
                Container(
                  width: width,
                  child: Text(
                    'Registro',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20, fontFamily: 'Medium'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  height: height * 0.6,
                  child: Stack(
                    children: [
                      Container(
                        child: Transform.rotate(
                          angle: pi / 15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff00BFA6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            width: width * 0.76,
                            height: height * 0.46,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.76,
                        height: height * 0.46,
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
                                Text(
                                  'Correo :',
                                  style: TextStyle(fontFamily: 'Medium'),
                                ),
                                SizedBox(height: 6.0),
                                TextFormField(
                                  validator: (value) {
                                    return value.isEmpty
                                        ? "Ingrese un Nombre"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Nombre",
                                  ),
                                  onChanged: (value) {
                                    name = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Contrasena :',
                                  style: TextStyle(fontFamily: 'Medium'),
                                ),
                                SizedBox(height: 6.0),
                                TextFormField(
                                  validator: (value) {
                                    return value.isEmpty
                                        ? "Ingrese un Usuario"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Usuario",
                                  ),
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Contrasena :',
                                  style: TextStyle(fontFamily: 'Medium'),
                                ),
                                SizedBox(height: 6.0),
                                TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    return value.isEmpty
                                        ? "Ingrese la contraseña"
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
                                Container(
                                    width: width,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff00BFA6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text('Registrarme'))),
                                SizedBox(
                                  height: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: height * 0.1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ya tienes una cuenta creada ? ",
                              style: TextStyle(
                                fontFamily: 'Medium',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                "Ingresa",
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: appBar(context),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //     brightness: Brightness.light,
    //   ),
    //   body: _isLoading
    //       ? Container(
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         )
    //       : Form(
    //           key: _formKey,
    //           child: Container(
    //             margin: EdgeInsets.symmetric(horizontal: 24.0),
    //             child: Column(
    //               children: [
    //                 Spacer(),
    //                 TextFormField(
    //                   validator: (value) {
    //                     return value.isEmpty ? "Ingrese un Nombre" : null;
    //                   },
    //                   decoration: InputDecoration(
    //                     hintText: "Nombre",
    //                   ),
    //                   onChanged: (value) {
    //                     name = value;
    //                   },
    //                 ),
    //                 SizedBox(height: 6.0),
    //                 TextFormField(
    //                   validator: (value) {
    //                     return value.isEmpty ? "Ingrese un Usuario" : null;
    //                   },
    //                   decoration: InputDecoration(
    //                     hintText: "Usuario",
    //                   ),
    //                   onChanged: (value) {
    //                     email = value;
    //                   },
    //                 ),
    //                 SizedBox(height: 6.0),
    //                 TextFormField(
    //                   obscureText: true,
    //                   validator: (value) {
    //                     return value.isEmpty ? "Ingrese la contraseña" : null;
    //                   },
    //                   decoration: InputDecoration(
    //                     hintText: "Contraseña",
    //                   ),
    //                   onChanged: (value) {
    //                     password = value;
    //                   },
    //                 ),
    //                 SizedBox(
    //                   height: 14,
    //                 ),
    //                 Container(
    //                     width: double.infinity,
    //                     child: ElevatedButton(
    //                         onPressed: () {
    //                           //signUp();
    //                           signUp();
    //                         },
    //                         child: Text('Registrarse'))),
    //                 SizedBox(
    //                   height: 18,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text("Ya tienes una cuenta creada ? "),
    //                     GestureDetector(
    //                       onTap: () {
    //                         Navigator.pushReplacement(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => SignIn()));
    //                       },
    //                       child: Text(
    //                         "Ingresa",
    //                         style:
    //                             TextStyle(decoration: TextDecoration.underline),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 60,
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    // );
  }
}
