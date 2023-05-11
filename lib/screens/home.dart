import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../widgets/image_container.dart';
import '../widgets/no_internet.dart';
import '../widgets/error_msg.dart';
import '../utils/image_operations.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _imageName;
  late Future<Uint8List?> _imageBytesFuture;
  bool _like = false;

  @override
  void initState() {
    super.initState();
    _imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';
    _imageBytesFuture = getImageFromWeb('https://picsum.photos/900/1500');
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
      child: FutureBuilder<Uint8List?>(
        future: _imageBytesFuture,
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: Icon(icon),
                        label: Text('Like'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: null,
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading image'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _imageBytesFuture = getImageFromWeb('https://picsum.photos/900/1500');
                      });
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Try again'),
                  ),
                ),
              ],
            );
          } else if (snapshot.data == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => NoInternetDialog(),
              );
            });
            return Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading image'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _imageBytesFuture = getImageFromWeb('https://picsum.photos/900/1500');
                      });
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Try again'),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: AspectRatio(
                        aspectRatio: 3 / 5,
                        child: ImageContainer(
                          imageSource: snapshot.data!,
                          borderRadius: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _like = !_like;
                          });
                          if (_like) {
                            saveImage(snapshot.data!, _imageName);
                            print(_imageName);
                          } else {
                            deleteImage(_imageName);
                            print(_imageName);
                          }
                        },
                        icon: Icon(icon),
                        label: Text('Like'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _like = false;
                            _imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';
                            _imageBytesFuture = getImageFromWeb('https://picsum.photos/900/1500');
                          });
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
