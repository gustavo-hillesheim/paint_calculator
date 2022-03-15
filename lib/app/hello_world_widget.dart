import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloWorldWidget extends StatelessWidget {
  const HelloWorldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Hello World')));
  }
}
