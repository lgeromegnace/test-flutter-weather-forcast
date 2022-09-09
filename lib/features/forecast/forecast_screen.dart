import 'package:flutter/material.dart';

class ForeCastScreen extends StatefulWidget {
  const ForeCastScreen({Key? key}) : super(key: key);

  @override
  State<ForeCastScreen> createState() => _ForeCastScreenState();
}

class _ForeCastScreenState extends State<ForeCastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue XXX'),
      ),
      body: Container(),
    );
  }
}