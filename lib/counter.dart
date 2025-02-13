import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int num = 0;

  void add() {
    setState(() {
      num++;
    });
  }

  void substract() {
    if (num > 0) {
      setState(() {
        num--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                add();
              },
              child: Text("+"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(num.toString()),
            ),
            ElevatedButton(
              onPressed: () {
                substract();
              },
              child: Text("-"),
            )
          ],
        ),
      ),
    );
  }
}
