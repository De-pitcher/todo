import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/screens/todo_item.dart';
import 'package:to_do/to_do_state.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer(builder: ((context, ref, child) {
      final todosState = ref.watch(todosNotifierProvider);
      return todosState.when(
          data: (todos) {
            return RefreshIndicator(
                child: ListView(
                  children: [
                    ...todos
                        .map((todo) => ProviderScope(
                            overrides: [currentTodo.overrideWithValue(todo)],
                            child: const TodoItem()))
                        .toList()
                  ],
                ),
                onRefresh: () =>
                    ref.read(todosNotifierProvider.notifier).refresh());
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          error: ((error, stackTrace) => const Center(
                child: Text('Sonething went wrong'),
              )));
    })));
  }
}
