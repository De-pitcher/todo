// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

@immutable
class Todo {
  final String id;
  final String description;
  final bool completed;

  Todo(
    this.description, {
    this.completed = false,
    String? id,
  }) : id = id ?? _uuid.v4();
}
