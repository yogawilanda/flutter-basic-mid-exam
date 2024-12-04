import 'package:flutter_mid_basic_exam/helper/db_helper.dart';
import 'package:flutter_mid_basic_exam/model/tasks.dart';
import 'package:sqflite/sqflite.dart';

class TaskService {
  final DBHelper dbHelper = DBHelper.instance;
  final tableName = 'tasks';

  Future<int> createTask(Task task) async {
    final db = await dbHelper.database;

    return await db.insert(
      tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> readAllTask() async {
    final db = await dbHelper.database;

    final result = await db.query(tableName);

    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await dbHelper.database;
    return db.update(
      tableName,
      task.toMap(),
      where: 'taskID = ?',
      whereArgs: [task.taskID],
    );
  }

  Future<int> deleteTask(int taskID) async {
    final db = await dbHelper.database;
    return await db.delete(
      tableName,
      where: 'taskID = ?',
      whereArgs: [taskID],
    );
  }

  Future<int> deleteAllTask() async {
    final db = await dbHelper.database;
    return await db.delete(tableName);
  }

  Future<int> countTask() async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result)!;
    return count;
  }

  Future<List<Task>> readAllTaskByStatus(bool isCompleted) async {
    final db = await dbHelper.database;
    final result = await db.query(
      tableName,
      where: 'isCompleted = ?',
      whereArgs: [isCompleted ? 1 : 0],
    );
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> updateTaskStatus(int taskID, bool isCompleted) async {
    final db = await dbHelper.database;
    return db.update(
      tableName,
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'taskID = ?',
      whereArgs: [taskID],
    );
  }

  Future<void> close() async {
    final db = await dbHelper.database;

    db.close();
  }

  Future<int> deleteAllCompletedTask() async {
    final db = await dbHelper.database;
    return await db.delete(tableName, where: 'isCompleted = ?', whereArgs: [1]);
  }

  Future<int> deleteAllUncompletedTask() async {
    final db = await dbHelper.database;
    return await db.delete(tableName, where: 'isCompleted = ?', whereArgs: [0]);
  }

  Future<int> deleteAllTaskByStatus(bool isCompleted) async {
    final db = await dbHelper.database;
    return await db.delete(tableName,
        where: 'isCompleted = ?', whereArgs: [isCompleted ? 1 : 0]);
  }

  Future<int> deleteTaskByStatus(int taskID, bool isCompleted) async {
    final db = await dbHelper.database;
    return await db.delete(tableName,
        where: 'taskID = ? AND isCompleted = ?',
        whereArgs: [taskID, isCompleted ? 1 : 0]);
  }

  Future<int> updateTaskStatusByStatus(
      int taskID, bool isCompleted, bool newStatus) async {
    final db = await dbHelper.database;
    return db.update(
      tableName,
      {'isCompleted': newStatus ? 1 : 0},
      where: 'taskID = ? AND isCompleted = ?',
      whereArgs: [taskID, isCompleted ? 1 : 0],
    );
  }
}
