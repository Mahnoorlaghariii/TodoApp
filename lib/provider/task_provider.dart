import 'package:flutter/cupertino.dart';
import 'package:todolist/models/tasks.dart';

class TaskProvider with ChangeNotifier {
  List<Tasks> _tasks = [];
  List<Tasks> get tasks => _tasks;


  void addTasks(Tasks task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskStatus(Tasks task){
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(Tasks task){
    _tasks.remove(task);
    notifyListeners();
  }

  void deleteAll(){
    _tasks.clear();
    notifyListeners();
  }

    void markAllDone() {
    for (var task in _tasks) {
      task.isCompleted = true;
    }
    notifyListeners();
  }

   List<Tasks> filteredTasks(String filter) {
    if (filter == 'Completed') {
      return _tasks.where((t) => t.isCompleted).toList();
    } else if (filter == 'Pending') {
      return _tasks.where((t) => !t.isCompleted).toList();
    }
    return _tasks;
  }
}
