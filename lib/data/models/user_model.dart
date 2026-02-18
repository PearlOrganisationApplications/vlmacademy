enum UserRole { student, teacher, parent, admin }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;
  final String? profileImage;
  final String? classLevel; // For students (e.g., "Class 10")
  final String? board; // For students (e.g., "CBSE")
  final List<String>? subjects; // For students/teachers
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    this.profileImage,
    this.classLevel,
    this.board,
    this.subjects,
    required this.createdAt,
    this.lastLoginAt,
    this.isActive = true,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      profileImage: json['profileImage'] as String?,
      classLevel: json['classLevel'] as String?,
      board: json['board'] as String?,
      subjects: (json['subjects'] as List<dynamic>?)?.cast<String>(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toString().split('.').last,
      'profileImage': profileImage,
      'classLevel': classLevel,
      'board': board,
      'subjects': subjects,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Copy with
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? profileImage,
    String? classLevel,
    String? board,
    List<String>? subjects,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      classLevel: classLevel ?? this.classLevel,
      board: board ?? this.board,
      subjects: subjects ?? this.subjects,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
