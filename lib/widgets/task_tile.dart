import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;

  const TaskTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white38,
      child: ListTile(
        leading: Checkbox(
          value: false,
          onChanged: (bool? value) {
            value = false;
          },
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
    );
  }
}
