import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double weight = 70;
  double height = 170;

  String result = "Enter your stats";
  Color resultColor = Colors.white;

  void calculateBMI() {
    double heightM = height / 100;
    double bmi = weight / (heightM * heightM);

    String category;

    if (bmi < 18.5) {
      category = "Underweight";
      resultColor = Colors.blue;
    } else if (bmi < 25) {
      category = "Normal";
      resultColor = Colors.green;
    } else if (bmi < 30) {
      category = "Overweight";
      resultColor = Colors.orange;
    } else {
      category = "Obese";
      resultColor = Colors.red;
    }

    setState(() {
      result = "BMI: ${bmi.toStringAsFixed(1)}\n$category";
    });
  }

  Widget buildControl({
    required String title,
    required double value,
    required Function(double) onChanged,
    required double min,
    required double max,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),

            // Value + Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (value > min) onChanged(value - 1);
                  },
                ),
                Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (value < max) onChanged(value + 1);
                  },
                ),
              ],
            ),

            // Slider
            Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildControl(
              title: "Weight (kg)",
              value: weight,
              min: 30,
              max: 150,
              onChanged: (val) {
                setState(() {
                  weight = val;
                });
              },
            ),

            SizedBox(height: 20),

            buildControl(
              title: "Height (cm)",
              value: height,
              min: 100,
              max: 220,
              onChanged: (val) {
                setState(() {
                  height = val;
                });
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("Calculate", style: TextStyle(fontSize: 18)),
            ),

            SizedBox(height: 20),

            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: resultColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}