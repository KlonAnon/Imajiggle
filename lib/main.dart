import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '/navigation/navigation.dart';

import 'models/home_model.dart';
import 'models/gallery_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GalleryModel()),
        ChangeNotifierProvider(create: (context) => HomeModel()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Imajiggle'),
        ),
        body: NavigationPage(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 34, 174, 255)),
      ),
    );
  }
}
