import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../widgets/image_container.dart';
import '../widgets/no_internet.dart';
import '../utils/check_internet.dart';
import '../utils/get_image.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Uint8List> _imageBytesFuture;

  @override
  void initState() {
    super.initState();
    _imageBytesFuture = getImageFromWeb('https://picsum.photos/200/300');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<Uint8List>(
            future: _imageBytesFuture,
            builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading image');
              } else {
                return ImageContainer(
                  imageBytes: snapshot.data!,
                  width: 200,
                  height: 300,
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () async {
              bool hasInternet = await checkInternet();
              if (hasInternet) {
                setState(() {
                  _imageBytesFuture = getImageFromWeb('https://picsum.photos/200/300');
                });
              } else {
                if (context.mounted) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => NoInternetDialog(),
                  );
                }
              }
            },
            child: Text('Generate'),
          ),
        ],
      ),
    );
  }
}
