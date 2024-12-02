
import 'package:flutter_mid_basic_exam/model/tasks.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Future<Database> _initDB(String filePath) async {
  //   final dbPath = await getDatabasesPath();
  //   final path = dbPath + filePath;

  //   return await openDatabase(path, version: 1, onCreate: _createDB);
  // }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE tasks (
  taskID INTEGER PRIMARY KEY AUTOINCREMENT,
  taskName TEXT NOT NULL,
  taskDescription TEXT,
  isCompleted INTEGER NOT NULL
)
''');

    await db.execute(
        ''' CREATE TABLE users ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL ) ''');
  }

  Future<int> createTask(Task task) async {
    final db = await instance.database;

    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //read All Task
  Future<List<Task>> readAllTask() async {
    final db = await instance.database;

    final result = await db.query('tasks');

    return result.map((json) => Task.fromMap(json)).toList();
  }

  // update task
  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return db.update(
      'tasks',
      task.toMap(),
      where: 'taskID = ?',
      whereArgs: [task.taskID],
    );
  }

  // delete task
  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'taskID = ?',
      whereArgs: [id],
    );
  }

  Future close() async {}
}
