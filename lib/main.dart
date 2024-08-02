import 'package:flutter/material.dart';
import 'table_generator_screen.dart';
void main() => runApp(TableGeneratorApp());

class TableGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Table Generator',
            style: TextStyle(
              fontSize: 22,
              letterSpacing: 2.5,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                BoxShadow(
                  color: Colors.black38,
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
        body: TableGeneratorScreen(),
      )
    );
  }
}
