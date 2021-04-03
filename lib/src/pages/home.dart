import 'package:flutter/material.dart';
import 'package:quizmaker_app/src/pages/create_quizz.dart';
import 'package:quizmaker_app/src/pages/play_quiz.dart';
import 'package:quizmaker_app/src/services/database.dart';

import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  final String userId;
  Home(this.userId);
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
              style: TextStyle(fontSize: 20),
            ),
          ),
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              //print('length = ${snapshot.data.docs.length}');
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index) {
                  print('ALGO' + snapshot.data.docs[index].data()["quizTitle"]);
                  return QuizTile(
                    userId: widget.userId,
                    imgUrl: snapshot.data.docs[index].data()["quizImgUrl"],
                    desc: snapshot.data.docs[index].data()["quizDescription"],
                    quizId: snapshot.data.docs[index].data()["quizId"],
                    title: snapshot.data.docs[index].data()["quizTitle"],
                  );
                },
              );
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
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            color: Colors.grey,
          )
        ],
      ),
      body: quizList(),
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlayQuiz(userId, quizId)));
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
