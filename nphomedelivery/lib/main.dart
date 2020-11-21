import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Mapping.dart';
import 'adItem.dart';

void main() {
  runApp(QuizThursday());
}

class QuizThursday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Quiz Thursday',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MappingPage(
        auth: Auth(),
      ),
      routes: {
        '/aditem': (context) => AdItem(),
        
      },
    );
  }
}
