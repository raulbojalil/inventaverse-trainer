import 'package:flutter/material.dart';
import 'package:inventaverse_trainer/app_config.dart';
import 'package:inventaverse_trainer/screens/main_screen.dart';

import 'constants.dart';

void main({String? env}) async {
  await AppConfig.forEnvironment(env);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaverse Trainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: primaryBgColor,
        canvasColor: secondaryColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainScreen(),
    );
  }
}
