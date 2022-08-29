import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/repositories/fake_to_do_repository.dart';
import 'package:to_do/screens/to_do_screen.dart';
import 'package:to_do/to_do_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        todoRepositoryProvider.overrideWithValue(FakeTodoRepository())
      ],
      child: MaterialApp(
        title: 'Reading Providers',
        debugShowCheckedModeBanner: false,
        home: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: const ToDoScreen()),
      ),
    );
  }
}
