class Task {
  // variables
  int? taskID;
  String taskName;
  String? taskDescription;
  bool isCompleted;

  // constructor
  Task(
      {this.taskID,
      required this.taskName,
      this.taskDescription,
      required this.isCompleted});

  // model conversion to Map
  Map<String, dynamic> toMap() {
    return {
      'taskID': taskID,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // model conversion from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskID: map['taskID'],
      taskName: map['taskName'],
      taskDescription: map['taskDescription'],
      isCompleted: map['isCompleted'] == 1 ? true : false,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskID: json['taskID'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isCompleted: json['isCompleted'] == 1 ? true : false,
    );
  }
}
