import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/check_internet.dart';

// Model of the home screen
class HomeModel extends ChangeNotifier {
  Uint8List? currentImage;

  late Future<Uint8List?> _futureImage;
  Future<Uint8List?> get futureImage => _futureImage;

  IconData _likeIcon = Icons.favorite_border;
  IconData get likeIcon => _likeIcon;
  bool _like = false;
  bool get like => _like;

  // set the _like value and the icon accordingly
  // that way the like button appears to be toggled
  set like(bool value) {
    _like = value;
    if (_like) {
      _likeIcon = Icons.favorite;
    } else {
      _likeIcon = Icons.favorite_border;
    }
    notifyListeners();
  }

  // constructor of the home model
  HomeModel() {
    _futureImage = getImageFromWeb();
  }

  // Function for getting a random image from the web using lorem picsum
  Future<Uint8List?> getImageFromWeb() async {
    bool hasInternet = await checkInternet();
    // if theres an internet connection send a http get to lorem picsum
    if (hasInternet) {
      final response = await http.get(Uri.parse('https://picsum.photos/900/1500'));
      return response.bodyBytes;
      // return null if theres no internet connection
    } else {
      return null;
    }
  }

  // generate a new image by calling getImageFromWeb and reset _like and _likeIcon
  void generateImage() {
    _futureImage = getImageFromWeb();
    _like = false;
    _likeIcon = Icons.favorite_border;
    notifyListeners();
  }
}
