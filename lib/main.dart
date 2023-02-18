import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uresrs/repository/user_repository.dart';
import 'package:uresrs/view/home_page.dart';

void main() async {
  await Hive.initFlutter();
  UserRepository().registerAdapter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}