import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatelessWidget {
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('tasks');

  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do App')),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('tasks');

  void _editTask(BuildContext context, String id, String currentTitle) {
    showDialog(
      context: context,
      builder: (context) => EditTaskDialog(id: id, currentTitle: currentTitle),
    );
  }

  void _deleteTask(String id) {
    _tasks.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _tasks.orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        var docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var task = docs[index];
            return ListTile(
              title: Text(task['title']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTask(context, task.id, task['title']),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(task.id),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _taskController = TextEditingController();
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('tasks');

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      _tasks.add({'title': _taskController.text, 'timestamp': Timestamp.now()});
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: TextField(controller: _taskController),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _addTask,
          child: Text('Add'),
        ),
      ],
    );
  }
}

class EditTaskDialog extends StatefulWidget {
  final String id;
  final String currentTitle;

  EditTaskDialog({required this.id, required this.currentTitle});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _taskController;
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('tasks');

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.currentTitle);
  }

  void _editTask() {
    if (_taskController.text.isNotEmpty) {
      _tasks.doc(widget.id).update({'title': _taskController.text});
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: TextField(controller: _taskController),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _editTask,
          child: Text('Update'),
        ),
      ],
    );
  }
}
