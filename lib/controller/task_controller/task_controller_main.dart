part of 'task_controller_libraries.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  final TaskService taskService = TaskService();

  TaskController() {
    loadTask();
  }

  Future<void> loadTask() async {
    final taskService = TaskService();
    tasks = await taskService.readAllTask();
    notifyListeners();
  }

  //--------- Task Counter ------------
  Future<int> countTask() async {
    return tasks.length;
  }

  Future<void> createTask(String taskName, {VoidCallback? onTaskAdded}) async {
    final task = Task(taskName: taskName, isCompleted: false);
    await taskService.createTask(task);
    await loadTask();

    if (onTaskAdded != null) {
      onTaskAdded();
    }
  }

  void updateTask(Task task) {
    final index = tasks.indexWhere((t) => t.taskID == task.taskID);
    if (index != -1) {
      tasks[index] = task;
      taskService.updateTask(task);
      notifyListeners();
    }
  }

  void deleteTask(int taskId) {
    tasks.removeWhere((task) => task.taskID == taskId);
    notifyListeners();
  }

  // mekanisme menghitung jumlah task yang sudah selesai berdasarkan status
  int countCompletedTasks() {
    return tasks.where((task) => task.isCompleted).length;
  }
}

