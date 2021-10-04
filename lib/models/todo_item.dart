import 'package:flutter/painting.dart';

enum Importance { low, medium, high }

class ToDoItem {
  final String id;
  final String name;
  final Importance importance;
  final Color color;
  final DateTime date;
  final bool isComplete;
  ToDoItem(
      {this.id,
      this.name,
      this.importance,
      this.color,
      this.date,
      this.isComplete = false});
  ToDoItem copyWith(
      {String id,
      String name,
      Importance importance,
      Color color,
      DateTime date,
      bool isComplete}) {
    return ToDoItem(
        id: id ?? this.id,
        name: name ?? this.name,
        importance: importance ?? this.importance,
        color: color ?? this.color,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete);
  }
}
