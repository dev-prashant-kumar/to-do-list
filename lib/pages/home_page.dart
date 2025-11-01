import 'package:flutter/material.dart';
import 'package:to_do_app/utill/dialog.dart';
import '../utill/todo_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage>{

  final _controller = TextEditingController();

  List todoList=[
    ["make a program",false],
    ["do exercise",false],
  ];

  void checkBoxChanged(bool? value, int index){
    setState(() {
      todoList[index][1]= !todoList[index][1];
    });
  }

  void saveNewTask(){
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //create new task
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),

        );
        },
    );
  }

  //delete task
  void deleteTask(int index){
   setState(() {
     todoList.removeAt(index);
   });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold (
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("TO DO"),
        elevation: 0,

      ),
      floatingActionButton: FloatingActionButton(onPressed: createNewTask,
      child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context,index){
          return TodoTile(
            taskName: todoList[index][0],
              taskCompleted: todoList[index][1],
              onChanged: (value)=> checkBoxChanged(value, index),
              deleteFunction : (context) => deleteTask,              
              );
        }
      ),
    );
  }
}