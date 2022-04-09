import 'package:flutter/material.dart';

class StatusLayout extends StatelessWidget {
  final String message;

  StatusLayout({
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
