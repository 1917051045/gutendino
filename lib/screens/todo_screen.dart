import 'package:flutter/material.dart';
import 'package:gutendino/models/todo_manager.dart';
import 'package:provider/provider.dart';

import 'todo_item_screen.dart';
import 'todo_list_screen.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<ToDoManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ToDoItemScreen(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      ),
      body: buildToDoScreen(),
    );
  }

  Widget buildToDoScreen() {
    return Consumer<ToDoManager>(
      builder: (context, manager, child) {
        if (manager.toDoItems.isNotEmpty) {
          return ToDoListScreen(manager: manager);
        } else {
          return Center(
            child: Text("List Empty"),
          );
        }
      },
    );
  }
}
