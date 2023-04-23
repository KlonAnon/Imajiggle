import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../widgets/image_container.dart';
import '../widgets/no_internet.dart';
import '../utils/check_internet.dart';
import '../utils/image_operations.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _imageName;
  late Future<Uint8List> _imageBytesFuture;
  bool _like = false;

  @override
  void initState() {
    super.initState();
    _imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';
    _imageBytesFuture = getImageFromWeb('https://picsum.photos/200/300');
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (_like) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

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
                  imageSource: snapshot.data!,
                  borderRadius: 10,
                );
              }
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    _like = !_like;
                  });
                  if (_like) {
                    final imageBytes = await _imageBytesFuture;
                    saveImage(imageBytes, _imageName);
                    print(_imageName);
                  } else {
                    deleteImage(_imageName);
                    print(_imageName);
                  }
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  bool hasInternet = await checkInternet();
                  if (hasInternet) {
                    setState(() {
                      _like = false;
                      _imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';
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
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
