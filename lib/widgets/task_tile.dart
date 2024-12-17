import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isCompleted; //false -> true
  final VoidCallback onDelete;
  final ValueChanged<bool?> onCheckboxChanged;

  const TaskTile({
    super.key,
    required this.title,
    required this.onDelete,
    required this.isCompleted,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white38,
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: onCheckboxChanged,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isCompleted ? null : FontWeight.w800,
            color: isCompleted ? Colors.red : Colors.green,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
