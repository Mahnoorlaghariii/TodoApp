import 'package:flutter/material.dart';
import 'package:todolist/models/tasks.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final taskProv = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 41, 41),
      appBar: AppBar(
        title: Text("Add Tasks"),
        backgroundColor: Color.fromARGB(255, 43, 41, 41),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 160, 159, 159).withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 91, 86, 86),
                      ), // Border color when focused
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _desController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 91, 86, 86),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 43, 41, 41),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1),
                  ),
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _desController.text.isNotEmpty) {
                      taskProv.addTasks(
                        Tasks(
                          title: _titleController.text,
                          description: _desController.text,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
