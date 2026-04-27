import 'package:flutter/material.dart';

class ClassTrackingScreen extends StatelessWidget {
  const ClassTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Tracking'),
      ),
      body: const Center(
        child: Text('Class Tracking Screen'),
      ),
    );
  }
}
