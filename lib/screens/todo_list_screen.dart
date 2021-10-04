import 'package:flutter/material.dart';
import '../components/todo_tile.dart';
import '../models/manager_models.dart';
import 'todo_item_screen.dart';

class ToDoListScreen extends StatelessWidget {
  final ToDoManager manager;
  const ToDoListScreen({Key key, this.manager}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final toDoItems = manager.toDoItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          itemCount: toDoItems.length,
          itemBuilder: (context, index) {
            final item = toDoItems[index];
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
              onDismissed: (direction) {
                manager.deleteItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.name} dismissed'),
                  ),
                );
              },
              child: InkWell(
                child: ToDoTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    manager.completeItem(index, change);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ToDoItemScreen(
                        originalItem: item,
                        onUpdate: (item) {
                          manager.updateItem(item, index);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          }),
    );
  }
}
