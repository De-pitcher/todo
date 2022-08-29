import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/screens/todo_item.dart';
import 'package:to_do/to_do_state.dart';

class CompletedTodos extends ConsumerWidget {
  const CompletedTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(completedTodosProvider);
    return todosState.when(
      data: (todos) => ListView(
        children: [
          ...todos
              .map((todo) => ProviderScope(
                  overrides: [currentTodo.overrideWithValue(todo)],
                  child: const TodoItem()))
              .toList()
        ],
      ),
      error: (e, st) => const Center(
        child: Text('Something went wrong'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
