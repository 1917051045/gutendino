import 'package:flutter/material.dart';
import 'todo_item.dart';

class ToDoManager extends ChangeNotifier {
  final _toDoItems = <ToDoItem>[];
  List<ToDoItem> get toDoItems => List.unmodifiable(_toDoItems);
  void deleteItem(int index) {
    _toDoItems.removeAt(index);
    notifyListeners();
  }

  void addItem(ToDoItem item) {
    _toDoItems.add(item);
    notifyListeners();
  }

  void updateItem(ToDoItem item, int index) {
    _toDoItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _toDoItems[index];
    _toDoItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
