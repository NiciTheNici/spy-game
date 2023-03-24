import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Taschenrechner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class History {
  var firstValue = 0.0;
  var secondValue = 0.0;
  var operand = "";

  History(this.firstValue, this.secondValue, this.operand);
}

class _MyHomePageState extends State<MyHomePage> {
  List<History> history = [];

  Map<String, String> operands = {
    "add": "+",
    "sub": "-",
    "mul": "*",
    "div": "/",
    "equals": "=",
  };
  var output = "0";
  var valueOfOperation = 0.0;
  var firstValue = 0.0;
  var secondValue = 0.0;
  var operand = "";

  buttonPressed(String buttonText) {
    print(history.length);
    if (buttonText == "Clear") {
      valueOfOperation = 0.0;
      firstValue = 0.0;
      secondValue = 0.0;
      operand = "";
      //Wenn gleich gedrückt wird
    } else if (buttonText == operands["equals"]) {
      secondValue = double.parse(output);
      history.add(
          History(firstValue, secondValue, operand)); //todo add check for empty
      if (operand == operands["add"]) {
        valueOfOperation = firstValue + secondValue;
      } else if (operand == operands["sub"]) {
        valueOfOperation = firstValue - secondValue;
      } else if (operand == operands["mul"]) {
        valueOfOperation = firstValue * secondValue;
      } else if (operand == operands["div"]) {
        valueOfOperation = firstValue / secondValue;
      }
      firstValue = 0.0;
      secondValue = 0.0;
      operand = "";
      //Wenn ein anderer Operand gedrückt wird
    } else if (operands.containsValue(buttonText)) {
      firstValue = double.parse(output);
      operand = buttonText;
      valueOfOperation = 0.0;
      //Wenn eine Zahl gedrückt wird
    } else {
      if (valueOfOperation == 0.0) {
        valueOfOperation = double.parse(buttonText);
      } else {
        var zahlensplit = valueOfOperation.toString().split(".");
        var ganzzahl = zahlensplit[0];
        var kommazahl = zahlensplit[1];
        valueOfOperation =
            double.parse(ganzzahl + buttonText + "." + kommazahl);
      }
    }
    setState(
      () {
        var valueOfOperationString = valueOfOperation.toString();
        var valueOfOperationSplit = valueOfOperationString.split(".");
        if (valueOfOperationSplit[1] == "0") {
          output = valueOfOperationSplit[0];
        } else {
          output = valueOfOperationString;
        }
      },
    );
  }

  Widget counterButton(var buttonText) {
    return Expanded(
      child: OutlinedButton(
        key: Key('Taste' + buttonText),
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText,
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(24.0)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              //backgroundColor: Colors.yellow,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                output,
                key: Key('Resultat'),
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    counterButton("7"),
                    counterButton("8"),
                    counterButton("9"),
                    counterButton(operands["div"]),
                  ],
                ),
                Row(
                  children: <Widget>[
                    counterButton("4"),
                    counterButton("5"),
                    counterButton("6"),
                    counterButton(operands["mul"]),
                  ],
                ),
                Row(
                  children: <Widget>[
                    counterButton("1"),
                    counterButton("2"),
                    counterButton("3"),
                    counterButton(operands["sub"]),
                  ],
                ),
                Row(
                  children: <Widget>[
                    counterButton("0"),
                    counterButton("Clear"),
                    counterButton(operands["equals"]),
                    counterButton(operands["add"]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
