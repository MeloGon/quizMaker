import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/services/database.dart';
import 'package:quizmaker_app/src/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String userId;
  final String quizId;
  AddQuestion(this.userId, this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      // print("${widget.quizId}");
      databaseService
          .addQuestionData(questionMap, widget.userId, widget.quizId)
          .then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: appBar(context),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
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
                            'Contenido del Quiz',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Enunciado de la Pregunta :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Ingrese el enunciado" : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: "Ingrese enunciado"),
                        onChanged: (val) {
                          question = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Opcion A (Respuesta Correcta) :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Ingrese la opcion" : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: "Opcion A y la vez respuesta correcta"),
                        onChanged: (val) {
                          option1 = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Opcion B :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Ingrese la opcion" : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: "Opcion B"),
                        onChanged: (val) {
                          option2 = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Opcion C :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Ingrese la opcion" : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: "Opcion C"),
                        onChanged: (val) {
                          option3 = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Opcion D :'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Ingrese la opcion" : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xffAAAAAA).withOpacity(0.29),
                            filled: true,
                            hintText: "Opcion D"),
                        onChanged: (val) {
                          option4 = val;
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff00BFA6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Terminar'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff00BFA6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                onPressed: () {
                                  uploadQuizData();
                                },
                                child: Text('Anadir Pregunta'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
