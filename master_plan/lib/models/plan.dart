import './task.dart';

class Plan {
  String name = '';
  final List<Task> tasks = [];

  int get completeCount => tasks.where((task) => task.complete ?? false).length;

  String get completenessMessage => '$completeCount out of ${tasks.length} tasks';
}