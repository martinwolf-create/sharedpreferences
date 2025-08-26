import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/task_list/widgets/empty_content.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/task_list/widgets/item_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> _items = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  Future<void> _updateList() async {
    setState(() => isLoading = true);
    _items
      ..clear()
      ..addAll(await widget.repository.getItems());
    setState(() => isLoading = false);
  }

  Future<void> _addItem(String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    await widget.repository.addItem(trimmed);
    _controller.clear();
    await _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Checkliste'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _items.isEmpty
                      ? const EmptyContent()
                      : ItemList(
                          repository: widget.repository,
                          items: _items,
                          updateOnChange: _updateList,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Todo Hinzufügen",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          await _addItem(_controller.text);
                        },
                      ),
                    ),
                    onSubmitted: (value) async {
                      await _addItem(value);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
