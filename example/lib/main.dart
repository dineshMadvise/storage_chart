import 'package:storage_chart/storage_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  List<DataModel> storageData = [
    DataModel(amount: 2000, color: Colors.red),
    DataModel(amount: 500, color: Colors.yellow),
    DataModel(amount: 1000, color: Colors.orange),
    DataModel(amount: 1500, color: Colors.purple),
    DataModel(amount: 1500, color: Colors.yellow),
  ];

  num totalStorage =10000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StorageChatLayout(
          totalStorage: totalStorage,
          storageData: storageData,
        ),
      ),
    );
  }
}
