import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../utils/check_internet.dart';

Future<Uint8List?> getImageFromWeb(String url) async {
  bool hasInternet = await checkInternet();
  if (hasInternet) {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  } else {
    return null;
  }
}

Future<List<File>> getImagesFromDirectory() async {
  Directory directory = await getApplicationDocumentsDirectory();
  List<FileSystemEntity> files = directory.listSync();

  List<File> imageFiles = files
      .where((file) {
        return file is File && file.path.endsWith('.jpg');
      })
      .map((file) => File(file.path))
      .toList();

  return imageFiles;
}

Future<void> saveImage(Uint8List imageBytes, String imageName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$imageName';
  final imageFile = File(filePath);
  await imageFile.writeAsBytes(imageBytes);
}

Future<void> deleteImage(String imageName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$imageName';
  final file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }
}
