import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final bool completed;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completed ? Colors.green : Colors.grey,
        ),
        title: Text(title),
      ),
    );
  }
}
