import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'main.dart';
import 'constants.dart';

class TableDisplayScreen extends StatelessWidget {
  final int tableNumber;
  final int startingPoint;
  final int endingPoint;

  TableDisplayScreen({
    required this.tableNumber,
    required this.startingPoint,
    required this.endingPoint,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        centerTitle: true,
        title: Text(
          'Table Display',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 2.5,
            fontWeight: FontWeight.bold,
            shadows: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(3, 1),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff330867),
                Color(0xff30cfd0),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            width: size.width,
            height: size.height,
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
          ),
          // Content
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = startingPoint; i <= endingPoint; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '$tableNumber x $i = ${tableNumber * i}',
                          style: kLabelStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(
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
                      child: Text('Generate Quiz', style: kLabelStyle),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
