enum CourseType { recorded, live }

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String teacherId;
  final String teacherName;
  final String? thumbnailUrl;
  final String? videoUrl;
  final CourseType type;
  final int durationMinutes;
  final String subject;
  final String classLevel;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? scheduledAt; // For live classes
  final int viewCount;
  final double rating;
  final bool isPremium;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.teacherName,
    this.thumbnailUrl,
    this.videoUrl,
    required this.type,
    required this.durationMinutes,
    required this.subject,
    required this.classLevel,
    this.tags = const [],
    required this.createdAt,
    this.scheduledAt,
    this.viewCount = 0,
    this.rating = 0.0,
    this.isPremium = false,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      type: CourseType.values.firstWhere(
        (e) => e.toString() == 'CourseType.${json['type']}',
      ),
      durationMinutes: json['durationMinutes'] as int,
      subject: json['subject'] as String,
      classLevel: json['classLevel'] as String,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'] as String)
          : null,
      viewCount: json['viewCount'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'type': type.toString().split('.').last,
      'durationMinutes': durationMinutes,
      'subject': subject,
      'classLevel': classLevel,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'scheduledAt': scheduledAt?.toIso8601String(),
      'viewCount': viewCount,
      'rating': rating,
      'isPremium': isPremium,
    };
  }
}
