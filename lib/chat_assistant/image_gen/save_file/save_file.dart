import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    //Чтобы проверить, дано ли разрешение этому приложению или нет.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // Если нет, мы спросим разрешения.
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Перенаправляет его в папку загрузки в Android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    //Чтобы получить внешний путь от устройства к папке загрузки
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(String name, String nameCopy) async {
    final path = await _localPath;
    // Создаём файл по пути
    // имя устройства и файла с расширением

    File file= File(name);

    //
    return file.copy('$path/$nameCopy');
  }
}