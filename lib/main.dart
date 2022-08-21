import 'package:animatedfab/circularfab.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DecoratedBox(
          child: SizedBox(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("best.jpg"), fit: BoxFit.cover),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                title: const Text(
              'Animated Fab',
            )),
            floatingActionButton: const CircularFab())
      ],
    );
  }
}
