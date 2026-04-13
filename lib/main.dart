
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _expression = '';
  String _result = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '<') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          // Substitui 'x' por '*' e '÷' por '/' para avaliação
          String finalExpression = _expression.replaceAll('x', '*').replaceAll('÷', '/');
          Parser p = Parser();
          Expression exp = p.parse(finalExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          // Trata casos de overflow e underflow
          if (eval.isInfinite) {
             _result = 'Erro: Overflow';
          } else if (eval.isNaN) {
            _result = 'Erro: Indefinido';
          }
          else {
            _result = eval.toString();
          }

        } catch (e) {
          _result = 'Erro';
        }
      } else {
        _expression += buttonText;
      }
    });
  }
  
  void _toggleSign() {
    setState(() {
      if (_expression.startsWith('-')) {
        _expression = _expression.substring(1);
      } else {
        _expression = '-$_expression';
      }
    });
  }


  Widget _buildButton(
      String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            if (buttonText == '+/-') {
              _toggleSign();
            } else {
              _buttonPressed(buttonText);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(24.0),
            shape: const CircleBorder(),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
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
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          // Display
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 28, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    _buildButton('C', Colors.grey[300]!, Colors.black),
                    _buildButton('<', Colors.grey[300]!, Colors.black),
                    _buildButton('()', Colors.grey[300]!, Colors.black),
                    _buildButton('÷', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('7', Colors.grey[850]!, Colors.white),
                    _buildButton('8', Colors.grey[850]!, Colors.white),
                    _buildButton('9', Colors.grey[850]!, Colors.white),
                    _buildButton('x', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4', Colors.grey[850]!, Colors.white),
                    _buildButton('5', Colors.grey[850]!, Colors.white),
                    _buildButton('6', Colors.grey[850]!, Colors.white),
                    _buildButton('-', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1', Colors.grey[850]!, Colors.white),
                    _buildButton('2', Colors.grey[850]!, Colors.white),
                    _buildButton('3', Colors.grey[850]!, Colors.white),
                    _buildButton('+', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('+/-', Colors.grey[850]!, Colors.white),
                    _buildButton('0', Colors.grey[850]!, Colors.white),
                    _buildButton('.', Colors.grey[850]!, Colors.white),
                    _buildButton('=', Colors.orange, Colors.white),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
