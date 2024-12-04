import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/helper/db_helper.dart';
import 'package:flutter_mid_basic_exam/helper/tasks_service.dart';
import 'package:flutter_mid_basic_exam/model/tasks.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// permission handler

class TaskController extends ChangeNotifier {
  final TaskService dbHelper = TaskService();
  List<Task> tasks = [];

  Future<void> refreshTask() async {
    tasks = await dbHelper.readAllTask();
    notifyListeners();
  }

  Future<void> addTask(String taskName, {VoidCallback? onTaskAdded}) async {
    final task = Task(taskName: taskName);
    await dbHelper.createTask(task);
    await refreshTask();

    if (onTaskAdded != null) {
      onTaskAdded();
    }
  }

  Future<void> updateTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    await dbHelper.updateTask(task);
    refreshTask();
  }

  Future<void> deleteTask(int id) async {
    await dbHelper.deleteTask(id);
    refreshTask();
  }

  //--------- Request Permission ------------
  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission is required.');
    }
  }

  Future<void> openConfigurationHandler() async {
    openAppSettings();
  }

  Future<void> requestManageStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      debugPrint('Permission granted');
    } else {
      debugPrint('Permission denied');
    }
  }

  Future<void> openDownloadFolder() async {
    final downloadsPath = '/storage/emulated/0/Download';
    final downloadsUri = Uri.parse('file://$downloadsPath');

    if (await canLaunchUrl(downloadsUri)) {
      await launchUrl(downloadsUri, mode: LaunchMode.externalApplication);
      debugPrint('Opened folder: $downloadsPath');
    } else {
      debugPrint('Could not open folder: $downloadsPath');
    }
  }

  Future<void> createFolderInExternalStorage() async {
    // Request storage permission and handle the response with a ternary operator
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      debugPrint('Storage permission not granted.');
      return;
    }

    // Get the external storage directory or handle failure
    final externalDir = await getExternalStorageDirectory();
    if (externalDir == null) {
      debugPrint('Failed to get external storage directory.');
      return;
    }

    // Define the folder path in the external storage's "Download" directory
    final folderPath = '${externalDir.parent.path}/Downloads/MyFolder';

    // Create the folder if it doesn't exist, using ternary operator
    (await Directory(folderPath).exists())
        ? debugPrint('Folder already exists at: $folderPath')
        : await Directory(folderPath).create(recursive: true).then((_) {
            debugPrint('Folder created at: $folderPath');
          });
  }

  Future<bool> checkPermissionStatus() {
    const permission = Permission.mediaLibrary;

    return permission.isGranted;
  }

  Future<void> exportTaskToJson() async {
    final jsonString = jsonEncode(tasks.map((task) => task.toJson()).toList());
    final externalDirectory = await getExternalStorageDirectory();
    final downloadsPath =
        Directory('${externalDirectory!.parent.path}/Download');

    if (!(await downloadsPath.exists())) {
      await downloadsPath.create(recursive: true);
    }

    final file = File('${downloadsPath.path}/tasks.json');
    await file.writeAsString(jsonString);
  }

  Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get getLocalFile async {
    final path = await getLocalPath;
    return File('$path/tasks.json');
  }

  Future<File> get getExternalFile async {
    final externalDirectory = await getExternalStorageDirectory();
    final downloadsPath =
        Directory('${externalDirectory!.parent.path}/Download');
    return File('${downloadsPath.path}/tasks.json');
  }

  // write to local storage
  Future<File> writeToFile(String data) async {
    final file = await getLocalFile;
    return file.writeAsString(data);
  }

  Future<void> uploadTask() async {
    debugPrint("uploading task to server");

    dbHelper.readAllTask().then((value) async {
      value.forEach((element) {
        debugPrint("Task Name: ${element.taskName}");
      });

      // save as json in local debugger
      final jsonString =
          jsonEncode(value.map((task) => task.toJson()).toList());
      debugPrint(jsonString);

      // save as json in local file
      final file = File('tasks.json');
      await file.writeAsString(jsonString);
    });
  }
}
