import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      _AchievementItem(title: 'First Task', description: 'Complete your first verified task', unlocked: true),
      _AchievementItem(title: '10 Tasks', description: 'Complete 10 approved tasks', unlocked: true),
      _AchievementItem(title: '3-Day Streak', description: 'Maintain a three-day streak', unlocked: false),
      _AchievementItem(title: 'Level 10', description: 'Reach level 10', unlocked: false),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: achievements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  return Card(
                    color: achievement.unlocked ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            achievement.unlocked ? Icons.emoji_events_rounded : Icons.lock_rounded,
                            size: 28,
                            color: achievement.unlocked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            achievement.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            achievement.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
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

class _AchievementItem {
  const _AchievementItem({required this.title, required this.description, required this.unlocked});

  final String title;
  final String description;
  final bool unlocked;
}
