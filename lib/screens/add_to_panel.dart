import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/to_do_state.dart';

class AddTodoPanel extends ConsumerStatefulWidget {
  const AddTodoPanel({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoPanelState();
}

class _AddTodoPanelState extends ConsumerState<AddTodoPanel> {
  final _textEditingController = TextEditingController();

  void _summit([String? value]) {
    ref
        .read(todosNotifierProvider.notifier)
        .add(_textEditingController.value.text);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'New todo'),
              onSubmitted: _summit,
            ),
          ),
          IconButton(onPressed: _summit, icon: const Icon(Icons.check))
        ],
      ),
    );
  }
}
