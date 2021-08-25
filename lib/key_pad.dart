import 'package:flutter/material.dart';

import 'main.dart';

// ignore: must_be_immutable
class KeyPadWidget extends StatelessWidget {
  final CustomColor customColor = CustomColor();
  final String label;
  String operators = "";

  Function onTap;
  KeyPadWidget({this.label, this.onTap, this.operators});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
          onPressed: onTap,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
            ),
          ),
          style: TextButton.styleFrom(
            // padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: (operators == "+" ||
                    operators == "-" ||
                    operators == "/" ||
                    operators == "x" ||
                    operators == "=" ||
                    operators == "CLR")
                ? Colors.blue.withOpacity(0.5)
                : customColor.keysColor,
          )),
    );
  }
}
