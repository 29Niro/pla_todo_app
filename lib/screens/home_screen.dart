import 'package:flutter/material.dart';
import 'package:pla_todo_app/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _tasks =
      []; //_tasks = [{'title': 'new task'}, {'title': 'another'}];

  void _addTask(String taskTitle) {
    setState(() {
      _tasks.add({'title': taskTitle});
    });
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController _taskController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add New Task"),
            content: TextField(
              controller: _taskController,
              decoration: const InputDecoration(hintText: "Enter a Task"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  if (_taskController.text.isNotEmpty) {
                    _addTask(_taskController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Add"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do App"),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index]; // task = {'title': "new 1"}
          return TaskTile(title: task['title']); // task['title'] = "new 1"
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}