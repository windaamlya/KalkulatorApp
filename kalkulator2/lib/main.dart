import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
      } else if (buttonText == "=") {
        try {
          output = evaluatedExpression(output);
        } catch (e) {
          output = "error";
        }
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  String evaluatedExpression(String expression) {
    final parsedExpression = Expression.parse(expression);
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});
    return result.toString();
  }

  Widget buildButton(String buttonText, Color color, {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 0,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 24, right: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 89, color: Colors.white),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", Colors.grey.shade600),
                  buildButton("+/-", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7", Colors.grey.shade600),
                  buildButton("8", Colors.grey.shade600),
                  buildButton("9", Colors.grey.shade600),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey.shade600),
                  buildButton("5", Colors.grey.shade600),
                  buildButton("6", Colors.grey.shade600),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey.shade600),
                  buildButton("2", Colors.grey.shade600),
                  buildButton("3", Colors.grey.shade600),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", Colors.grey.shade600, widthFactor: 2.0),
                  buildButton(",", Colors.grey.shade600),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
