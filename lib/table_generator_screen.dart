import 'package:flutter/material.dart';
import 'table_display_screen.dart';
import 'quiz_screen.dart';
import 'constants.dart';

class TableGeneratorScreen extends StatefulWidget {
  @override
  _TableGeneratorScreenState createState() => _TableGeneratorScreenState();
}

class _TableGeneratorScreenState extends State<TableGeneratorScreen> {
  int tableNumber = 10;
  int startingPoint = 1;
  int endingPoint = 15;

  Widget buildSlider({
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white, // Set the color to white
            fontWeight: FontWeight.bold, // Set the font to bold
            fontSize: 18, // Optional: Adjust the font size
          ),
        ),
        Stack(
          children: [
            Slider(
              value: value.toDouble(),
              min: min.toDouble(),
              max: max.toDouble(),
              divisions: max - min,
              label: value.toString(),
              onChanged: onChanged,
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Text(
                '$min',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the color to white
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 2,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Text(
                '$max',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the color to white
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 2,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff30cfd0),
              Color(0xff330867),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildSlider(
                label: 'Table Number',
                value: tableNumber,
                min: 1,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    tableNumber = value.toInt();
                  });
                },
              ),
              buildSlider(
                label: 'Table Starting Point',
                value: startingPoint,
                min: 1,
                max: endingPoint - 1,
                // Ensure startingPoint is less than endingPoint
                onChanged: (value) {
                  setState(() {
                    startingPoint = value.toInt();
                    if (endingPoint <= startingPoint) {
                      endingPoint = startingPoint + 1;
                    }
                  });
                },
              ),
              buildSlider(
                label: 'Table Ending Limit',
                value: endingPoint,
                min: startingPoint + 1,
                // Ensure endingPoint is greater than startingPoint
                max: 100,
                onChanged: (value) {
                  setState(() {
                    endingPoint = value.toInt();
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TableDisplayScreen(
                        tableNumber: tableNumber,
                        startingPoint: startingPoint,
                        endingPoint: endingPoint,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.orange,
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Generate Table',
                  style: kLabelStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
