import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/screens/add_to_panel.dart';
import 'package:to_do/screens/completed_todo.dart';
import 'package:to_do/screens/menu.dart';
import 'package:to_do/screens/todo_list.dart';
import 'package:to_do/to_do_state.dart';

class ToDoScreen extends ConsumerWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(todoExceptionProvider,
        <TodoException>(exceptionState, nextexceptionState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            exceptionState.state!.error.toString(),
          ),
        ),
      );
    });
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text(
              'TODOS',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white,fontSize: 30),
            ),
            actions: const [Menu()],
            bottom: const TabBar(tabs: [
              Text(
                'All',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
              Text(
                'Completed',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ]),
          ),
          body: SafeArea(
              child: TabBarView(children: [
            Column(
              children: const [
                AddTodoPanel(),
                SizedBox(height: 20),
                TodoList(),
              ],
            ),
            const CompletedTodos()
          ])),
        ));
  }
}
