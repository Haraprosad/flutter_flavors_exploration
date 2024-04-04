import 'package:flutter/material.dart';
import 'package:flutter_flavors_exploration/flavors/env_config.dart';

Future<void> runMainApp() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
  final EnvConfig envConfig = EnvConfig.instance;

    return Scaffold(
      appBar: AppBar(title: Text(envConfig.appName),),
      body: Center(
        child: Text(
          envConfig.baseUrl,
        ),
      )
    );
  }
}