import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample1/counter.dart';
import 'package:sample1/screan1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}
