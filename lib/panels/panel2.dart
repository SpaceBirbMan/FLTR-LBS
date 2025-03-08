import 'package:flutter/material.dart';

class Panel2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: Center(
        child: Text('Панель', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}