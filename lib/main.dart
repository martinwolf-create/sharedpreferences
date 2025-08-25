import "package:flutter/material.dart";
import "perstistence.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePerstistence();
  // SharedPreferences starten
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SharedPrefs von NOTEkey",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 57, 43, 13),
        ),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _nameController = TextEditingController();
  String _savedName = "";
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  void _loadAll() {
    _savedName = loadUserName();
    _isDark = loadDarkMode();
    if (_savedName.isNotEmpty) {
      _nameController.text = _savedName;
    }
    setState(() {});
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();
    await saveUserName(name);
    setState(() => _savedName = name);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Name gespeichert")));
  }

  Future<void> _toggleDark(bool value) async {
    await saveDarkMode(value);
    setState(() => _isDark = value);
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _savedName.isEmpty
        ? "Noch kein Name gespeichert."
        : "Hallo, $_savedName!";

    return Scaffold(
      appBar: AppBar(title: const Text("SharedPreferences")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // name speichern
          Text("Dein Name", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: "Name, here please",
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _saveName(),
          ),
          const SizedBox(height: 12),
          FilledButton(onPressed: _saveName, child: const Text("Speichern")),
          const SizedBox(height: 16),
          Text(greeting),

          const Divider(height: 32),

          // dark/light mode switch
          SwitchListTile(
            title: const Text("Dark Mode aktivieren"),
            value: _isDark,
            onChanged: _toggleDark,
          ),
          const SizedBox(height: 8),
          Text(
            "Aktuell: ${_isDark ? "Dark Mode ist AKTIVIERT" : "Dark Mode ist AUS"}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
