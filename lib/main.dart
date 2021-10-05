import 'package:flutter/material.dart';

import 'package:iiserk_app/ui/home_page.dart';

void main() {
  runApp(IISERKApp());
}

class IISERKApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
