import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../providers/challenge_provider.dart';
import '../widgets/challenge_card.dart';
import '../widgets/progress_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(challengeProvider);

    final completed = items.where((e) => e.isCompleted).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Object Detective')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Find these Object around you',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ProgressWidget(
              completed: completed,
              total: AppConstants.totalItems,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return ChallengeCard(
                    title: item.name,
                    completed: item.isCompleted,
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/camera');
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Open Camera'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
