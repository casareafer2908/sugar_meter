import 'package:flutter/material.dart';
import 'package:sugar_meter/src/navigation/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sugar Meter',
        //Navigation
        onGenerateRoute: (settings) => Routes.routes(settings));
  }
}
