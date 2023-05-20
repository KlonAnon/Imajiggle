import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/check_internet.dart';

class HomeModel extends ChangeNotifier {
  Uint8List? currentImage;

  late Future<Uint8List?> _futureImage;
  Future<Uint8List?> get futureImage => _futureImage;

  IconData _likeIcon = Icons.favorite_border;
  IconData get likeIcon => _likeIcon;
  bool _like = false;
  bool get like => _like;

  set like(bool value) {
    _like = value;
    if (_like) {
      _likeIcon = Icons.favorite;
    } else {
      _likeIcon = Icons.favorite_border;
    }
    notifyListeners();
  }

  HomeModel() {
    _futureImage = getImageFromWeb();
  }

  Future<Uint8List?> getImageFromWeb() async {
    bool hasInternet = await checkInternet();
    if (hasInternet) {
      final response = await http.get(Uri.parse('https://picsum.photos/900/1500'));
      return response.bodyBytes;
    } else {
      return null;
    }
  }

  void generateImage() {
    _futureImage = getImageFromWeb();
    _like = false;
    _likeIcon = Icons.favorite_border;
    notifyListeners();
  }
}
