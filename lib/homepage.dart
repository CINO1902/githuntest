import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(child: Text("Caleb is a MF !",style: TextStyle(color: Colors.white),)),
    );
  }
}
