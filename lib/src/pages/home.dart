import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/create_quizz.dart';
import 'package:quizmaker_app/src/pages/play_quiz.dart';
import 'package:quizmaker_app/src/pages/signin.dart';
import 'package:quizmaker_app/src/services/database.dart';

import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  final String userId;
  final String typeUser;
  Home(this.userId, this.typeUser);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 25),
            width: double.infinity,
            alignment: Alignment.topRight,
            child: Text(
              'Lista de Quiz',
              style: TextStyle(
                  fontSize: 20, fontFamily: 'SemiBold', color: Colors.black54),
            ),
          ),
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "Aun no has creado algun Quiz, que esperas presiona en el boton de abajo. Sin miedo al exito",
                    style: TextStyle(
                        fontSize: 15.5,
                        fontFamily: 'SemiBold',
                        color: Colors.black54),
                  ),
                );
              } else {
//print('length = ${snapshot.data.docs.length}');
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    print(
                        'ALGO' + snapshot.data.docs[index].data()["quizTitle"]);
                    return QuizTile(
                      userId: widget.userId,
                      imgUrl: snapshot.data.docs[index].data()["quizImgUrl"],
                      desc: snapshot.data.docs[index].data()["quizDescription"],
                      quizId: snapshot.data.docs[index].data()["quizId"],
                      title: snapshot.data.docs[index].data()["quizTitle"],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData(widget.userId).then((value) {
      //print('VATO' + value.toString());
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
          )
        ],
      ),
      body: quizList(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff00BFA6),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateQuiz(widget.userId)));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String userId;
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;
  QuizTile({this.userId, this.imgUrl, this.title, this.quizId, this.desc});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          keyboardAware: true,
          dismissOnBackKeyPress: true,
          dialogType: DialogType.QUESTION,
          animType: AnimType.BOTTOMSLIDE,
          btnCancelText: "VER QUIZ",
          btnOkText: "OK",
          title: 'Que deseas realizar?',
          padding: const EdgeInsets.all(16.0),
          desc:
              'Si deseas ver tu codigo de profesor y el codigo del quiz presiona OK. Si deseas visualizar el quiz presiona VER QUIZ',
          btnCancelOnPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayQuiz(userId, quizId)));
          },
          btnOkOnPress: () {
            AwesomeDialog dialog;
            dialog = AwesomeDialog(
              context: context,
              animType: AnimType.TOPSLIDE,
              dialogType: DialogType.INFO,
              keyboardAware: true,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text('Tu id de Profesor es: $userId'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00BFA6),
                      ),
                      child: Text('Copiar Id Profesor'),
                      onPressed: () {
                        ClipboardManager.copyToClipBoard("$userId")
                            .then((result) {
                          final snackBar = SnackBar(
                            content: Text('Copiado al Portapeles'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        });
                      },
                    ),
                    Text('El id de tu Quiz es: $quizId'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00BFA6),
                      ),
                      child: Text('Copiar Id de Quiz'),
                      onPressed: () {
                        ClipboardManager.copyToClipBoard("$quizId")
                            .then((result) {
                          final snackBar = SnackBar(
                            content: Text('Copiado al Portapeles'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )..show();
          },
        ).show();
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => PlayQuiz(userId, quizId)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imgUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        desc,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
