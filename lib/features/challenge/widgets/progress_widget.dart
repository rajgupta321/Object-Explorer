import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressWidget({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = completed / total;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 10,
          borderRadius: BorderRadius.circular(20),
        ),
        const SizedBox(height: 8),
        Text(
          '$completed / $total Completed',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
