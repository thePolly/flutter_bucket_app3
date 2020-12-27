import 'package:flutter/material.dart';

class BucketCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Text("bla"),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter your username'),
          ),
        ]),
      ),
    );
  }
}
