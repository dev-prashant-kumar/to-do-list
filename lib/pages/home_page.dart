import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utill/dialog.dart';
import '../utill/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
      db.updateDatabase();
    } else {
      db.loadData();

     
      for (var task in db.todoList) {
        if (task.length == 2) {
          task.add(DateTime.now().toString());
        }
      }
      db.updateDatabase();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      db.todoList.add([
        _controller.text.trim(),
        false,
        DateTime.now().toIso8601String(), // Add date
      ]);
    });
    _controller.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void editTask(int index) {
    _controller.text = db.todoList[index][0];

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            setState(() {
              db.todoList[index][0] = _controller.text.trim();
              _controller.clear();
            });
            Navigator.pop(context);
            db.updateDatabase();
          },
          onCancel: () {
            _controller.clear();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        centerTitle: true,
        title: const Text(
          "Tasks",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editTask(index),
            dateTime: db.todoList[index][2], 
          );
        },
      ),
    );
  }
}
