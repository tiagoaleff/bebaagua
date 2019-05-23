import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Repositorio {

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  static Future<File> saveData(int media) async {
    String data = json.encode({"media": media});
    final file = await _getFile();
    return file.writeAsString(data);
  }

  static Future<String> getData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {}
  }
}
