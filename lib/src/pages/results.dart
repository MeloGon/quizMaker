import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizmaker_app/src/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results({this.correct, this.incorrect, this.total});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/check.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            Text(
              "${widget.correct}/${widget.total}",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Tienes ${widget.correct} respuestas correctas ${widget.incorrect} respuesas incorrectas",
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 14,
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
                  Navigator.pop(context);
                },
                child: Text('Ir al inicio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
