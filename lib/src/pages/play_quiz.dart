import 'package:flutter/material.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  @override
  void initState() {
    print('el id del quiz es ${widget.quizId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}