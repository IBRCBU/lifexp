import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingPages = [
      _OnboardingPage(
        title: 'Turn goals into XP',
        description: 'Track academic, personal, and routine tasks while building momentum with a game-like progress loop.',
        icon: Icons.rocket_launch_rounded,
      ),
      _OnboardingPage(
        title: 'Get verified',
        description: 'Each completed task can be checked by a parent, manager, or supervisor before XP is awarded.',
        icon: Icons.verified_user_rounded,
      ),
      _OnboardingPage(
        title: 'Stay consistent',
        description: 'Level up, maintain streaks, unlock achievements, and review your growth from one dashboard.',
        icon: Icons.auto_awesome_rounded,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                height: 380,
                child: PageView.builder(
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    final page = onboardingPages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(page.icon, size: 54, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingPages.length, (index) {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: index == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => context.go('/login'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Continue'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/register'),
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  const _OnboardingPage({required this.title, required this.description, required this.icon});

  final String title;
  final String description;
  final IconData icon;
}
