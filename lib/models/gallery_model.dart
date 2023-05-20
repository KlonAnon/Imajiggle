import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryModel extends ChangeNotifier {
  List<File> _imageFiles = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<File> get imageFiles => _imageFiles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  GalleryModel() {
    loadImagesFromDirectory();
  }

  void loadImagesFromDirectory() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      Directory directory = await getApplicationDocumentsDirectory();
      List<FileSystemEntity> files = directory.listSync();
      _imageFiles = files
          .where((file) {
            return file is File && file.path.endsWith('.jpg');
          })
          .map((file) => File(file.path))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }

  Future<void> saveImage(Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = File('${directory.path}/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg');
    await imageFile.writeAsBytes(imageBytes);

    _imageFiles.add(imageFile);
    notifyListeners();
  }

  Future<void> deleteImage(File imageFile) async {
    await imageFile.delete();
    _imageFiles.remove(imageFile);
    notifyListeners();
  }
}
