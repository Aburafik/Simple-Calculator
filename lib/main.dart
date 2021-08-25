import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'key_pad.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  CustomColor customColor = CustomColor();

// Array of button
  final List<String> buttons = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor._backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInput,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ///Clear Button to empty the two input fields
                specialButtons(
                    widget: Text("CLR"),
                    onTap: () {
                      setState(() {
                        userInput = "";
                        answer = "";
                      });
                    }),
              ],
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 14) {
                        return KeyPadWidget(
                          onTap: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          label: buttons[index],
                          operators: buttons[index],
                        );
                      } else {
                        return KeyPadWidget(
                          operators: buttons[index],
                          onTap: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          label: buttons[index],
                        );
                      }
                    }), // GridView.builder
              ),
            ),
          ],
        ),
      ),
    );
  }

// function to calculate the input operation
  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

// ignore: must_be_immutable

class CustomColor {
  Color _backgroundColor = Color.fromRGBO(30, 38, 53, 1);
  final Color keysColor = Color.fromRGBO(40, 51, 73, 1);
}

specialButtons({Widget widget, Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Container(margin: EdgeInsets.all(22), child: widget),
    ),
  );
}
