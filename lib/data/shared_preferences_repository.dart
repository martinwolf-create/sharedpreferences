import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _taskCountKey = "task_count";
  static const String _taskPrefix = "task_";

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  //aktuelle Anzahl an gespeicherten Tasks
  Future<int> _getCount() async {
    final prefs = await _prefs;
    return prefs.getInt(_taskCountKey) ?? 0;
  }

  Future<void> _setCount(int value) async {
    final prefs = await _prefs;
    await prefs.setInt(_taskCountKey, value);
  }

  String _taskKey(int index) => '$_taskPrefix$index';

  @override
  Future<int> getItemCount() => _getCount();

  @override
  Future<List<String>> getItems() async {
    final prefs = await _prefs;
    final count = await _getCount();
    final items = <String>[];
    for (int i = 0; i < count; i++) {
      final value = prefs.getString(_taskKey(i));
      if (value != null) {
        items.add(value);
      }
    }
    return items;
  }

  @override
  Future<void> addItem(String item) async {
    final prefs = await _prefs;
    final trimmed = item.trim();
    if (trimmed.isEmpty) return;

    final count = await _getCount();
    // doppelte vermeiden
    for (int i = 0; i < count; i++) {
      if (prefs.getString(_taskKey(i)) == trimmed) return;
    }

    await prefs.setString(_taskKey(count), trimmed);
    await _setCount(count + 1);
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await _prefs;
    final count = await _getCount();
    if (index < 0 || index >= count) return;

    // gewählten Task löschen
    await prefs.remove(_taskKey(index));

    // Task verschieben
    for (int i = index + 1; i < count; i++) {
      final value = prefs.getString(_taskKey(i));
      if (value != null) {
        await prefs.setString(_taskKey(i - 1), value);
      }
      await prefs.remove(_taskKey(i));
    }

    await _setCount(count - 1);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final prefs = await _prefs;
    final trimmed = newItem.trim();
    if (trimmed.isEmpty) return;

    final count = await _getCount();
    if (index < 0 || index >= count) return;

    // doppelte verhindern
    for (int i = 0; i < count; i++) {
      if (i != index && prefs.getString(_taskKey(i)) == trimmed) return;
    }

    await prefs.setString(_taskKey(index), trimmed);
  }
}
