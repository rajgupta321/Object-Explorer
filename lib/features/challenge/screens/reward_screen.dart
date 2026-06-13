import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../providers/challenge_provider.dart';
import '../widgets/reward_badge.dart';

class RewardScreen extends ConsumerWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(challengeProvider);

    final completed = items.where((e) => e.isCompleted).length;

    final challengeCompleted = completed == AppConstants.totalItems;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 100)),

              const SizedBox(height: 20),

              Text(
                challengeCompleted ? 'Challenge Completed!' : 'Great Job!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '$completed / ${AppConstants.totalItems} Object found',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 30),

              if (challengeCompleted) const RewardBadge(),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                child: Text(
                  challengeCompleted ? 'View Badge' : 'Continue Exploring',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
