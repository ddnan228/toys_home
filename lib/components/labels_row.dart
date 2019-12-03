

import 'package:flutter/material.dart';

class LablesRow extends StatelessWidget {
  LablesRow({this.labels,this.len, this.align, this.colour, this.fontsize});

  final List<dynamic> labels;
  final int len;
  final MainAxisAlignment align;
  final Color colour;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return get_labels();
  }

  Widget get_labels() {
    if (labels == null) {
      return Container();
    }

    var num = labels.length;
    if (num > len) {
      num = len;
    }
    List<Widget> boxes = [];
    for (var i = 0; i < num; i++) {
      boxes.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: colour,
          child: Container(
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
            child: Center(
              child: Text(
                labels[i].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontsize,
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisAlignment: align,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: boxes,
      ),
    );
  }
}
