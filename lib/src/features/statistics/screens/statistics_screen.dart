import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/statistics/widgets/task_counter_card.dart';

// Define the StatisticsScreen widget
class StatisticsScreen extends StatefulWidget {
  final DatabaseRepository repository;

  const StatisticsScreen({Key? key, required this.repository})
    : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTaskCount = 0;

  @override
  void initState() {
    super.initState();
    loadItemCount(); // <-- hierhin verschoben
  }

  void loadItemCount() async {
    int taskCount = await widget.repository.getItemCount();

    if (taskCount != currentTaskCount) {
      setState(() {
        currentTaskCount = taskCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(taskCount: currentTaskCount),
          ],
        ),
      ),
    );
  }
}
