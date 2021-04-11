import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/play_quiz.dart';
import 'package:quizmaker_app/src/pages/signin.dart';

import 'package:quizmaker_app/src/widgets/widgets.dart';

class TargetQuiz extends StatefulWidget {
  @override
  _TargetQuizState createState() => _TargetQuizState();
}

class _TargetQuizState extends State<TargetQuiz> {
  TextEditingController txtTeacherId = new TextEditingController();
  TextEditingController txtQuizId = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              'Cerrar Sesion',
              style: TextStyle(fontFamily: 'Regular', color: Color(0xff00BFA6)),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: txtTeacherId,
                style: TextStyle(fontFamily: 'Regular'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                  filled: true,
                  hintText: "ID de tu Profesor",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: txtQuizId,
                style: TextStyle(fontFamily: 'Regular'),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                  filled: true,
                  hintText: "ID del Quiz asignado",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff00BFA6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayQuiz(txtTeacherId.text, txtQuizId.text),
                        ),
                      );
                    },
                    child: Text(
                      'Comenzar Quiz',
                      style: TextStyle(fontFamily: 'SemiBold'),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Image.asset('assets/images/searching.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
