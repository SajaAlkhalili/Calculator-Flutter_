import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displaytxt = '0';

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(btncolor),
        foregroundColor: MaterialStateProperty.all(txtcolor),
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
      ),
      child: Text(
        btntxt,
        style: TextStyle(fontSize: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 209, 164, 207),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 206, 171, 219),
                        borderRadius: BorderRadius.circular(12),
                       
                      ),
                      child: Text(
                        displaytxt,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('AC', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Color.fromARGB(255, 138, 86, 158), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('7', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('8', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('9', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('x', Color.fromARGB(255, 138, 86, 158), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('4', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('5', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('6', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('-', Color.fromARGB(255, 138, 86, 158), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('1', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('2', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('3', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('+', Color.fromARGB(255, 138, 86, 158), Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 206, 171, 219)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32, vertical: 20)),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                calcbutton('.', Color.fromARGB(255, 206, 171, 219), Colors.white),
                calcbutton('=', Color.fromARGB(255, 138, 86, 158), Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1) : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      displaytxt = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return splitDecimal[0].toString();
    }
    return result;
  }
}
