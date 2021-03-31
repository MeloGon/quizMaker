import 'package:flutter/material.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ir al inicio')),
          ],
        ),
      ),
    );
  }
}
