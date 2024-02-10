import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pointz/common/constants/paths/path_strings.dart';

class LocalStaticMapImagesDataSource {
  static Future<bool> saveImageToLocalFileSystem(
      Uint8List imageFile, String id) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String documentsDirectoryPath = documentsDirectory.path;
    String mapImagesDirectoryPath =
        '$documentsDirectoryPath/${PathStrings.staticMapImagesFsPath}';

    try {
      Directory targetDirectory = Directory(mapImagesDirectoryPath);
      if (!await targetDirectory.exists()) {
        await targetDirectory.create(recursive: true);
      }

      File file = File('$mapImagesDirectoryPath/$id.png');
      await file.writeAsBytes(imageFile);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteImageFromLocalFileSystem(String id) async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String documentsDirectoryPath = documentsDirectory.path;
      String mapImagesDirectoryPath =
          '$documentsDirectoryPath/${PathStrings.staticMapImagesFsPath}';
      String filePath = '$mapImagesDirectoryPath/$id.png';

      File file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<File?> getImageFromLocalFileSystem(String id) async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String documentsDirectoryPath = documentsDirectory.path;
      String mapImagesDirectoryPath =
          '$documentsDirectoryPath/${PathStrings.staticMapImagesFsPath}';
      String filePath = '$mapImagesDirectoryPath/$id.png';

      File file = File(filePath);

      if (await file.exists()) {
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
