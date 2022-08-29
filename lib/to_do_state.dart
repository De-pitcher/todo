import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/to_do_exception.dart';
import 'package:to_do/models/models.dart';
import 'package:to_do/repositories/to_do_repository.dart';
import 'package:to_do/screens/to_do_notifier.dart';

final settingsProvider = StateProvider<Settings>((ref) => const Settings());

final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

final todoRepositoryProvider =
    Provider<TodoRepository>((ref) => throw UnimplementedError());

final todosNotifierProvider =
    StateNotifierProvider<TodosNotifier, AsyncValue<List<Todo>>>(
  (ref) => TodosNotifier(ref.read),
);

final completedTodosProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final todoState = ref.watch(todosNotifierProvider);
  return todoState
      .whenData((todos) => todos.where((todo) => todo.completed).toList());
});

final todoExceptionProvider = StateProvider<TodoException?>((ref) => null);
