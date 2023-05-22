import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// Model of the gallery screen
class GalleryModel extends ChangeNotifier {
  List<File> _imageFiles = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<File> get imageFiles => _imageFiles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  // constructor of the gallery model
  GalleryModel() {
    loadImagesFromDirectory();
  }

  // get all the images from the apps documents directory and store them inside the _imageFiles list
  void loadImagesFromDirectory() async {
    // indicate loading while the images are being fetched
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    // try fetching the images
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
      // catch any errors and set the _hasError to true instead
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }

  // save an image with the current time as filename to the apps documents directory 
  // by creating a file object and adding it to the _imageFiles list 
  Future<void> saveImage(Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = File('${directory.path}/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg');
    await imageFile.writeAsBytes(imageBytes);

    _imageFiles.add(imageFile);
    notifyListeners();
  }

  // delete an image by calling the delete method of the file object and remove it from the _imageFiles list
  Future<void> deleteImage(File imageFile) async {
    await imageFile.delete();
    _imageFiles.remove(imageFile);
    notifyListeners();
  }
}
