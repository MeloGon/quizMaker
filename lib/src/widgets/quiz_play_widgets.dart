import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  OptionTile(
      {this.option, this.description, this.correctAnswer, this.optionSelected});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.optionSelected == widget.description
                        ? widget.description == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            child: Text(
              "${widget.option}",
              style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? widget.description == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red
                      : Colors.black54),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              widget.description,
              style: TextStyle(fontSize: 17, color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
