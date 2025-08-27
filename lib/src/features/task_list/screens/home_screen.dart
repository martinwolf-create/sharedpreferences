import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/statistics/screens/statistics_screen.dart';

import 'list_screen.dart';

class HomeScreen extends StatefulWidget {
  final DatabaseRepository repository;

  const HomeScreen({Key? key, required this.repository}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 0;

  late final List<Widget> _navBarWidgets = [
    ListScreen(repository: widget.repository),
    StatisticsScreen(repository: widget.repository),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navBarWidgets[_selectedNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Aufgaben',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistik',
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        selectedItemColor: const Color.fromARGB(255, 65, 42, 17),
        onTap: (int index) {
          setState(() {
            _selectedNavBarIndex = index;
          });
        },
      ),
    );
  }
}
