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
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'BmiCalculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weightController = TextEditingController();
  var feetController = TextEditingController();
  var inchController = TextEditingController();
  var result = "";
  var msg = "";
  var backgroundColor = Colors.indigo.shade100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BMI",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    label: Text("Enter your weight (In kg)"),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: feetController,
                  decoration: InputDecoration(
                    label: Text("Enter your height in ft "),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: inchController,
                  decoration: InputDecoration(
                    label: Text("Enter your height in inch"),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    var wt = weightController.text.toString();
                    var ft = feetController.text.toString();
                    var inch = inchController.text.toString();

                    if (wt != "" && ft != "" && inch != "") {
                      //BMI calculation

                      var intWeight = int.parse(wt);
                      var intFeet = int.parse(ft);
                      var intInch = int.parse(inch);

                      var totalInch = (intFeet * 12) + intInch;
                      var totalcm = totalInch * 2.54;
                      var totalMeter = totalcm / 100;
                      var bmi = intWeight / (totalMeter * totalMeter);

                      //handling bg Color
                      if (bmi > 25) {
                        msg = "Overweight!";
                        backgroundColor = Colors.yellow.shade600;
                      } else if (bmi < 18) {
                        msg = "Underweight!";
                        backgroundColor = Colors.red.shade200;
                      } else {
                        msg = "Healthy👌";
                        backgroundColor = Colors.green.shade400;
                      }

                      setState(() {
                        msg = msg;
                        result = "Your BMI is :${bmi.toStringAsFixed(2)}";
                      });
                    } else {
                      setState(() {
                        result = "Please fill all the required fields!";
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text("Calculate"),
                ),
                SizedBox(height: 20),
                Text(msg, style: TextStyle(fontSize: 14)),
                Text(result, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
