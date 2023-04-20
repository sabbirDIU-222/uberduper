import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget
{
  static const String screenId = 'mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('UberDuper'),
      ),
    );
  }
}
