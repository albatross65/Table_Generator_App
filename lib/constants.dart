import 'package:flutter/material.dart';

const kLabelStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Color(0xff111328),  // Default color
  shadows: [
    Shadow(
      color: Colors.black38,
      blurRadius: 2,
      offset: Offset(2, 1),
    ),
  ],
);

const kNumberStyle = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.w900,
  color: Colors.black,
  shadows: [
    Shadow(
      color: Colors.black38,
      blurRadius: 2,
      offset: Offset(2, 1),
    ),
  ],
);

const activeColor = Color(0xff30cfd0);
const deActiveColor = Color(0xff330867);
