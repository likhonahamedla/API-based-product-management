import 'package:flutter/material.dart';

import 'crude_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment M16',
      debugShowCheckedModeBanner: false,
      home: CrudeHome(),
    );
  }
}
