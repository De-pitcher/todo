import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/settings.dart';
import 'package:to_do/to_do_state.dart';

enum MenuOptions { deleteOnComlete }

class Menu extends ConsumerWidget {
  const Menu({Key? key}) : super(key: key);

  Future<void> onSelected(WidgetRef ref, MenuOptions result) async {
    if (result == MenuOptions.deleteOnComlete) {
      final currentSetting =
          ref.read(settingsProvider.state).state.deleteOnComplete;
      ref.read(settingsProvider.state).state =
          Settings(deleteOnComplete: !currentSetting);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(settingsProvider.state).state.deleteOnComplete;
    return PopupMenuButton<MenuOptions>(
      onSelected: (result) {
        onSelected(ref, result);
      },
      icon: const Icon(Icons.menu),
      itemBuilder: (context) => <PopupMenuEntry<MenuOptions>>[
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.deleteOnComlete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Delete on complete'),
              Checkbox(
                value: isChecked,
                onChanged: null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
