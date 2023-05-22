import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'models/home_model.dart';
import 'models/gallery_model.dart';

import '/navigation/navigation.dart';

void main() {
  runApp(
    // // MultiProvider allows to provide multiple providers to the widget tree
    MultiProvider(
      providers: [
        // Create an instance of GalleryModel and provide it to the widget tree
        ChangeNotifierProvider(create: (context) => GalleryModel()),
        // Create an instance of HomeModel and provide it to the widget tree
        ChangeNotifierProvider(create: (context) => HomeModel()),
      ],
      child: const MainApp(), // root of the widget tree
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 34, 174, 255)), // apps color scheme
      ),
    );
  }
}
