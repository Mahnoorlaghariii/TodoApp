import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do App',
        home: const SplashScreen(),
      ),
    );
  }
}

