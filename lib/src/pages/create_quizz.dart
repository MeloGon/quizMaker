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
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) => value.isEmpty
                          ? 'Ingresa una iamgen para el Quiz'
                          : null,
                      decoration: InputDecoration(
                          hintText: 'Url de la imagen del Quizz'),
                      onChanged: (value) {
                        quizImageUrl = value;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (value) => value.isEmpty
                          ? 'Ingresa un titulo para el Quiz'
                          : null,
                      decoration:
                          InputDecoration(hintText: 'Titulo para el Quizz'),
                      onChanged: (value) {
                        quizTitle = value;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (value) => value.isEmpty
                          ? 'Ingresa una descripcion para el Quiz'
                          : null,
                      decoration:
                          InputDecoration(hintText: 'Descripcion del Quizz'),
                      onChanged: (value) {
                        quizDescription = value;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
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
    );
  }
}
