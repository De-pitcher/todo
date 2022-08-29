import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/to_do_exception.dart';
import 'package:to_do/models/to_do.dart';
import 'package:to_do/to_do_state.dart';

class TodosNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  final Reader read;
  AsyncValue<List<Todo>>? previousState;
  TodosNotifier(
    this.read, [
    AsyncValue<List<Todo>>? todos,
  ]) : super(todos ?? const AsyncValue.loading()) {
    _retrieveTodos();
  }

  Future<void> _retrieveTodos() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncData(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> retryLoadingTodo() async {
    state = const AsyncValue.loading();
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncData(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> refresh() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncData(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> add(String description) async {
    _cacheState();
    state = state.whenData((todos) => [...todos, Todo(description)]);

    try {
      await read(todoRepositoryProvider).addTodo(description);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> toggle(String id) async {
    if (read(settingsProvider).deleteOnComplete) {
      await remove(id);
    }

    _cacheState();

    state = state.whenData(
      (value) => value.map((todo) {
        if (todo.id == id) {
          return Todo(
            todo.description,
            id: todo.id,
            completed: !todo.completed,
          );
        }
        return todo;
      }).toList(),
    );
    try {
      await read(todoRepositoryProvider).toggle(id);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> edit({required String id, required String description}) async {
    _cacheState();
    state = state.whenData((todos) => [
          for (final todo in todos)
            if (todo.id == id)
              Todo(
                description,
                id: todo.id,
                completed: todo.completed,
              )
            else
              todo
        ]);
    try {
      await read(todoRepositoryProvider).edit(id: id, description: description);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> remove(String id) async {
    _cacheState();
    state = state.whenData(
      (value) => value.where((element) => element.id != id).toList(),
    );
    try {
      await read(todoRepositoryProvider).remove(id);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  void _cacheState() => previousState = state;

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }

  void _handleException(TodoException e) {
    _resetState();
    read(todoExceptionProvider.state).state = e;
  }
}
