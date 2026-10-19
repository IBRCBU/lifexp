import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queue = [
      _VerificationItem(title: 'Project 2 risk analysis', user: 'Aisha', priority: 'High'),
      _VerificationItem(title: 'Weekly fitness routine', user: 'John', priority: 'Medium'),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification queue',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: queue.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = queue[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text('${item.user} • ${item.priority} priority'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.close_rounded, color: Colors.red),
                          SizedBox(width: 10),
                          Icon(Icons.check_rounded, color: Colors.green),
                        ],
                      ),
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

class _VerificationItem {
  const _VerificationItem({required this.title, required this.user, required this.priority});

  final String title;
  final String user;
  final String priority;
}
