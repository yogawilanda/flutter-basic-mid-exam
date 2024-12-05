import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/task_controller/task_controller_libraries.dart';
import 'package:flutter_mid_basic_exam/model/tasks.dart';
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
      Provider.of<TaskController>(context, listen: false).loadTask();
    });
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.viewportDimension +
          MediaQuery.of(context).size.height * 2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _addTask(String taskName) {
    final taskController = Provider.of<TaskController>(context, listen: false);
    taskController.createTask(
      taskName,
      onTaskAdded: () {
        _scrollToBottom();
      },
    );

    taskCreateController.clear();
  }

  void saveTaskButtonAction() {
    final taskName = taskCreateController.text;
    if (taskName.isNotEmpty) {
      _addTask(taskName);
      taskCreateController.clear();
    }
  }

  bool isTaskListSelected = false;

  void countTask() {
    final taskController = Provider.of<TaskController>(context, listen: false);
    int completedCount = taskController.countCompletedTasks();
    print('Number of completed tasks: $completedCount');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: appBarCustom(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listViewTasks(),
          taskTextField(context),
        ],
      ),
    );
  }

  Padding taskTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.black),
              autocorrect: true,
              enableSuggestions: true,
              controller: taskCreateController,
              onEditingComplete: () {
                final taskName = taskCreateController.text;
                if (taskName.isNotEmpty) _addTask(taskName);
              },
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              // decoration: InputDecoration(
              //   hintText: 'Task',
              //   hintStyle: TextStyle(color: Colors.grey[400]),
              //   label: Text('Masukkan Task', style: TextStyle(color: Colors.grey[400])),
              //   prefixIcon: const Icon(Icons.task_alt),
              //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // ),

              decoration: InputDecoration(
                hintText: 'Task',
                hintStyle: TextStyle(color: Colors.grey[400]),
                labelText: 'Masukkan Task',
                labelStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon:
                    const Icon(Icons.task_alt, color: Colors.blueAccent),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.redAccent),
                  onPressed: () {
                    taskCreateController.clear();
                  },
                ),
                // filled: true,
                // fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.redAccent, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.redAccent, width: 2),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
    );
  }

  Expanded listViewTasks() {
    return Expanded(
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TaskController>(
          builder: (context, taskController, child) {
            return RefreshIndicator(
              onRefresh: taskController.loadTask,
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: taskController.tasks.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return listTaskComponent(task, taskController, index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ListTile listTaskComponent(
      Task task, TaskController taskController, int index) {
    return ListTile(
      title: Text(task.taskName),
      subtitle: Text(task.isCompleted ? 'Task Completed' : 'Task Incompleted'),
      leading: CircleAvatar(
        child: Text(task.taskID.toString()),
      ),
      trailing: Checkbox(
        value: taskController.tasks[index].isCompleted,
        onChanged: (value) {
          taskController.tasks[index].isCompleted = value!;
          taskController.updateTask(task);
        },
      ),
      onLongPress: () {
        taskController.deleteTask(task.taskID!);
      },
    );
  }

  Container appBarCustom(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(builder: (context, TaskController taskController, child) {
            return Text(
              'Completed Task: ${taskController.countCompletedTasks()}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            );
          }),
          IconButton.filledTonal(
            onPressed: () {
              final controller = Provider.of<TaskController>(
                context,
                listen: false,
              );
              controller.checkPermissionStatus();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              iconColor: WidgetStateProperty.all(Colors.green),
            ),
            icon: const Icon(
              Icons.upload,
              // color: Colors.green,
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
