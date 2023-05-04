import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String solution = "0";

  List<String> listofbuttons = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6.5,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  input,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: listofbuttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(
                    text: listofbuttons[index],
                    onPressed: () {
                      setState(() {
                        buttonhandling(listofbuttons[index]);
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void buttonhandling(String text) {
    if (text == "AC") {
      input = "";
      solution = "0";
      return;
    }
    if (text == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      } else {
        return;
      }
    }
    if (text == "=") {
      solution = calculate();
      input = solution;
      if (input.endsWith(".0")) {
        input = input.replaceAll(".0", "");
      }

      if (solution.endsWith(".0")) {
        solution = solution.replaceAll(".0", "");
        return;
      }
    }
    input = input + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(input);
      var evaluateans = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluateans.toString();
    } catch (e) {
      return "Error";
    }
  }
}

// ignore: non_constant_identifier_names
Widget CustomButton({required String text, required VoidCallback onPressed}) {
  return InkWell(
    splashColor: const Color(0xFF1d2630),
    onTap: onPressed,
    child: Ink(
      decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(-3, -3),
            ),
          ]),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: getColor(text), fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

getColor(String text) {
  if (text == "/" ||
      text == "*" ||
      text == "-" ||
      text == "+" ||
      text == "C" ||
      text == "(" ||
      text == ")") {
    return const Color.fromARGB(255, 252, 100, 100);
  }
  return Colors.white;
}

getBgColor(String text) {
  if (text == "AC") {
    return const Color.fromARGB(255, 252, 100, 100);
  }
  if (text == '=') {
    return const Color.fromARGB(255, 104, 204, 159);
  }
  return const Color.fromARGB(255, 84, 83, 62);
}
