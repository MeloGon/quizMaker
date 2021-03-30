import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/signup.dart';
import 'package:quizmaker_app/src/services/database.dart';
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
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty
                            ? "Ingrese un Usuario correcto"
                            : null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Usuario",
                        suffixIcon: Icon(Icons.supervised_user_circle_outlined),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        return value.isEmpty
                            ? "Ingrese la contraseña correcta"
                            : null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Contraseña",
                        suffixIcon: Icon(Icons.lock),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              signIn(email, password);
                            },
                            child: Text('Ingresar'))),
                    SizedBox(
                      height: 18,
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
                            style:
                                TextStyle(decoration: TextDecoration.underline),
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
