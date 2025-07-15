import 'package:flutter/material.dart';
import 'package:todolist/models/tasks.dart';

class TasksCard extends StatelessWidget {
  final Tasks task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  const TasksCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 166, 165, 165).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onToggle,
            icon: Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: Color.fromARGB(255, 200, 64, 64),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  task.description,
                   style: TextStyle( fontSize: 15,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: Colors.white,),
                ),
                 
              ],
            ),
            
          ),
            IconButton(
            icon: const Icon(Icons.delete, color: Color.fromARGB(255, 200, 64, 64)),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
