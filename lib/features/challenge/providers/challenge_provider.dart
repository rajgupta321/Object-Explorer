import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../models/challenge_item.dart';

class ChallengeNotifier extends StateNotifier<List<ChallengeItem>> {
  ChallengeNotifier()
    : super(
        AppConstants.requiredItems
            .map((item) => ChallengeItem(name: item, isCompleted: false))
            .toList(),
      );

  void markCompleted(String itemName) {
    state = state.map((item) {
      if (item.name == itemName) {
        return item.copyWith(isCompleted: true);
      }

      return item;
    }).toList();
  }

  int get completedCount => state.where((item) => item.isCompleted).length;

  bool get challengeCompleted => completedCount == AppConstants.totalItems;
}

final challengeProvider =
    StateNotifierProvider<ChallengeNotifier, List<ChallengeItem>>(
      (ref) => ChallengeNotifier(),
    );
