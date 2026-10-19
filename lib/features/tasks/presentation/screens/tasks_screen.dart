import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      _TaskItem(title: 'Prepare database design', priority: 'High', status: 'Pending verification'),
      _TaskItem(title: 'Read 20 pages for HCI', priority: 'Medium', status: 'Completed'),
      _TaskItem(title: 'Gym session', priority: 'Low', status: 'Todo'),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tasks',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                FloatingActionButton.small(
                  onPressed: () {},
                  child: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text('${task.priority} priority • ${task.status}'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskItem {
  const _TaskItem({required this.title, required this.priority, required this.status});

  final String title;
  final String priority;
  final String status;
}
