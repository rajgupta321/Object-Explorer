class ChallengeItem {
  final String name;
  final bool isCompleted;

  const ChallengeItem({required this.name, required this.isCompleted});

  ChallengeItem copyWith({String? name, bool? isCompleted}) {
    return ChallengeItem(
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
