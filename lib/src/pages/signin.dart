import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:quizmaker_app/src/pages/signup.dart';
import 'package:quizmaker_app/src/pages/target_quizz.dart';
import 'package:quizmaker_app/src/services/database.dart';

import 'package:quizmaker_app/src/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password, userId, typeUser;
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPass = new TextEditingController();
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  bool isCheck = false;
  List<String> data = new List<String>();

  @override
  void initState() {
    cargarPref();
    super.initState();
  }

  cargarPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    txtEmail = TextEditingController(text: prefs.get('correo'));
    txtPass = TextEditingController(text: prefs.get('pwd'));
    setState(() {});
  }

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
    if (email == "" || password == "") {
      toast('Ingrese correo y contrasena porfavor', Colors.grey[200],
          Colors.black, 14);
    } else {
      toast('Validando', Colors.grey[200], Colors.black, 14);
      setState(() {
        _isLoading = true;
      });

      var resp = await databaseService.getUser(email, password);
      data = await databaseService.getIdAndTypeUser(email, password);
      userId = data.isEmpty ? 'null' : data[0];
      typeUser = data.isEmpty ? 'null' : data[1];

      //print('tipo de usuario:' + data[1]);
      //userId = await databaseService.getIdUser(email, password);
      //print(userId);

      if (resp) {
        setState(() {
          _isLoading = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('correo', email);
        prefs.setString('pwd', password);
        toast('Credenciales validados correctamente', Colors.blue[200],
            Colors.white, 14);
        if (typeUser == "Alumno") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TargetQuiz()));
        } else {
          if (userId == 'null' || typeUser == 'null') {
            toast("El usuario no existe", Colors.orange[200], Colors.white, 14);
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(userId, typeUser)));
          }
        }
      } else {
        toast('Credenciales invalidos', Colors.red[200], Colors.white, 14);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    txtEmail.dispose();
    txtPass.dispose();
    super.dispose();
  }

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
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: width,
            height: height,
            child: Column(
              children: [
                Container(
                  width: width,
                  child: Text(
                    'Loguin',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SemiBold',
                        color: Colors.black54),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  height: height * 0.56,
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
                            height: height * 0.43,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.76,
                        height: height * 0.45,
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
                                TextField(
                                  // validator: (value) {
                                  //   return value.isEmpty
                                  //       ? "Ingrese un Usuario correcto"
                                  //       : null;
                                  // },
                                  controller: txtEmail,
                                  style: TextStyle(fontFamily: 'Regular'),
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
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Contrasena :',
                                  style: TextStyle(fontFamily: 'Medium'),
                                ),
                                SizedBox(height: 6.0),
                                TextFormField(
                                  obscureText: true,
                                  controller: txtPass,
                                  style: TextStyle(fontFamily: 'Regular'),
                                  // validator: (value) {
                                  //   return value.isEmpty
                                  //       ? "Ingrese la contraseña correcta"
                                  //       : null;
                                  // },
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
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: Color(0xff00BFA6),
                                      value: isCheck,
                                      onChanged: (value) {
                                        setState(() {});
                                        isCheck = value;
                                      },
                                    ),
                                    Text(
                                      'Recordar Contrasena',
                                      style: TextStyle(fontFamily: 'Medium'),
                                    )
                                  ],
                                ),
                                Container(
                                  width: width,
                                  child: FloatingActionButton(
                                    backgroundColor: Color(0xff00BFA6),
                                    onPressed: () {
                                      signIn(txtEmail.text, txtPass.text);
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
                    ],
                  ),
                ),
                Container(
                  height: height * 0.15,
                  child: Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Container(
                    height: height * 0.08,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Olvidaste tu contrasena ",
                              style: TextStyle(fontFamily: 'Medium'),
                            ),
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
                                    fontFamily: 'Medium',
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
                            Text(
                              "No tienes una cuenta aun ? ",
                              style: TextStyle(fontFamily: 'Medium'),
                            ),
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
                                    fontFamily: 'Medium',
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff00BFA6)),
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
  }
}
