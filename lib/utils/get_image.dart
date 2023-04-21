import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<Uint8List> getImageFromWeb(String url) async {
  final response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

//TODO: Images auch von Datei holen
//Future<Uint8List> getImageFromFile(File file)
