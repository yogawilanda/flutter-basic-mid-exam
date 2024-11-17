import 'package:flutter/material.dart';
import 'package:hello_flutter/controller/task_controller.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final taskCreateController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskController>(context, listen: false).refreshTask();
    });
  }

  void _addTask(String taskName) {
    final taskController = Provider.of<TaskController>(context, listen: false);
    taskController.addTask(
      taskName,
      onTaskAdded: () {
        // scroll to bottom
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      },
    );
  }

  void saveTaskButtonAction() {
    final taskName = taskCreateController.text;
    if (taskName.isNotEmpty) {
      _addTask(taskName);
      taskCreateController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // why the alignment is not working?
          Expanded(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TaskController>(
                builder: (context, taskController, child) {
                  return RefreshIndicator(
                    onRefresh: taskController.refreshTask,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: taskController.tasks.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final task = taskController.tasks[index];
                          return ListTile(
                            title: Text(task.taskName),
                            leading: CircleAvatar(
                              child: Text(task.taskID.toString()),
                            ),
                            trailing: Checkbox(
                              value: task.isCompleted,
                              onChanged: (value) {
                                taskController.updateTask(task);
                              },
                            ),
                            onLongPress: () {
                              taskController.deleteTask(task.taskID!);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskCreateController,
                    onEditingComplete: () {
                      final taskName = taskCreateController.text;
                      if (taskName.isNotEmpty) {
                        _addTask(taskName);
                        taskCreateController.clear();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'New Task',
                      labelText: 'Task Name',
                      prefixIcon: const Icon(Icons.task_alt),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: saveTaskButtonAction,
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  

  @override
  void dispose() {
    taskCreateController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
