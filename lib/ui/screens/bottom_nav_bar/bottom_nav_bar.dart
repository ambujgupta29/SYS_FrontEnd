import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  final dynamic arguments;
  const BottomNavBarScreen({super.key, this.arguments});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Container(),
    );
  }
}
