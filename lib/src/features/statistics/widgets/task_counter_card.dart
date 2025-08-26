import 'package:flutter/material.dart';

class TaskCounterCard extends StatelessWidget {
  final int taskCount;

  const TaskCounterCard({super.key, required this.taskCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color.fromARGB(26, 223, 208, 175),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 92, 60, 24),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$taskCount",
                  style: const TextStyle(
                    fontSize: 36,
                    color: Color.fromARGB(255, 234, 208, 159),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "Anzahl der offenen Tasks",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
