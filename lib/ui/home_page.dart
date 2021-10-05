import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IISER K'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Login Page'),
          ],
        ),
      ),
    );
  }
}
