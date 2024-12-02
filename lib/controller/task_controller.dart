import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/helper/db_helper.dart';
import 'package:flutter_mid_basic_exam/model/tasks.dart';

import 'package:path_provider/path_provider.dart';

class TaskController extends ChangeNotifier {
  final dbHelper = DBHelper.instance;
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

  Future<void> exportTaskToJson() async {
    try {
      final externalDirectory = await getExternalStorageDirectory();
      final downloadsPath = File('${externalDirectory!.parent.path}/Download');
      final file = File('${downloadsPath.path}/tasks.json');
      final jsonString = jsonEncode(tasks.map((task) => task.toJson()).toList());
      await file.writeAsString(jsonString);
      debugPrint('Exported to ${file.path}');
    } catch (e) {
      debugPrint('Error exporting tasks: $e');
    }
  }
}
