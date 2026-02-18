enum RewardType { dailyLogin, videoCompletion, testCompletion, streak, referral, spinWin }

class RewardModel {
  final String id;
  final String userId;
  final RewardType type;
  final int points;
  final String description;
  final DateTime earnedAt;

  RewardModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.points,
    required this.description,
    required this.earnedAt,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: RewardType.values.firstWhere(
        (e) => e.toString() == 'RewardType.${json['type']}',
      ),
      points: json['points'] as int,
      description: json['description'] as String,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString().split('.').last,
      'points': points,
      'description': description,
      'earnedAt': earnedAt.toIso8601String(),
    };
  }
}

class StreakModel {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastActivityDate;
  final List<DateTime> activityDates;

  StreakModel({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastActivityDate,
    required this.activityDates,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      userId: json['userId'] as String,
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      lastActivityDate: DateTime.parse(json['lastActivityDate'] as String),
      activityDates: (json['activityDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActivityDate': lastActivityDate.toIso8601String(),
      'activityDates': activityDates.map((e) => e.toIso8601String()).toList(),
    };
  }

  bool get isStreakActive {
    final now = DateTime.now();
    final difference = now.difference(lastActivityDate).inDays;
    return difference <= 1;
  }
}
