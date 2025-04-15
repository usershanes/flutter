import 'dart:async';

import 'package:flutter/material.dart';
//import './stopwatch.dart';
import './login_screen.dart';

void main() => runApp( StopwatchApp() );

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
