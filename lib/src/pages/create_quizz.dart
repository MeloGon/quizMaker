import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/add_question.dart';
import 'package:quizmaker_app/src/services/database.dart';
import 'package:random_string/random_string.dart';

import '../widgets/widgets.dart';

class CreateQuiz extends StatefulWidget {
  final String userId;
  CreateQuiz(this.userId);
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  addQuiz() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizDescription": quizDescription,
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
      };
      await databaseService
          .addQuizData(quizMap, widget.userId, quizId)
          .then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestion(widget.userId, quizId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
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
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: 10,
                          )),
                          Text(
                            'Crear Quiz',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Url de la imagen para el quiz :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => value.isEmpty
                            ? 'Ingresa una iamgen para el Quiz'
                            : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: 'ejemplo: https://imagen.jpg',
                            suffixIcon: Icon(Icons.link)),
                        onChanged: (value) {
                          quizImageUrl = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Titulo para el Quiz :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => value.isEmpty
                            ? 'Ingresa un titulo para el Quiz'
                            : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: 'ejemplo: Quiz de Arte',
                            suffixIcon: Icon(Icons.line_style)),
                        onChanged: (value) {
                          quizTitle = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Descripcion del Quiz :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => value.isEmpty
                            ? 'Ingresa una descripcion para el Quiz'
                            : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: 'ejemplo: Perspectiva',
                            suffixIcon: Icon(Icons.subject_rounded)),
                        onChanged: (value) {
                          quizDescription = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Image.asset('assets/images/test_online.png'),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff00BFA6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () {
                            addQuiz();
                          },
                          child: Text('Crear Quiz'),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
