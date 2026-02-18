import '../models/user_model.dart';
import '../models/wallet_model.dart';
import '../models/course_model.dart';
import '../models/test_model.dart';
import '../models/reward_model.dart';

class MockDataSource {
  // Mock Users
  static final List<UserModel> mockUsers = [
    UserModel(
      id: '1',
      name: 'Rahul Kumar',
      email: 'rahul@student.com',
      phone: '9876543210',
      role: UserRole.student,
      classLevel: 'Class 10',
      board: 'CBSE',
      subjects: ['Mathematics', 'Science', 'English'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLoginAt: DateTime.now(),
    ),
    UserModel(
      id: '2',
      name: 'Priya Sharma',
      email: 'priya@teacher.com',
      phone: '9876543211',
      role: UserRole.teacher,
      subjects: ['Mathematics', 'Physics'],
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      lastLoginAt: DateTime.now(),
    ),
  ];

  // Mock Courses
  static final List<CourseModel> mockCourses = [
    CourseModel(
      id: '1',
      title: 'Quadratic Equations - Complete Chapter',
      description: 'Learn quadratic equations with solved examples and practice problems',
      teacherId: '2',
      teacherName: 'Priya Sharma',
      type: CourseType.recorded,
      durationMinutes: 45,
      subject: 'Mathematics',
      classLevel: 'Class 10',
      tags: ['Algebra', 'Equations'],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      viewCount: 1250,
      rating: 4.5,
    ),
    CourseModel(
      id: '2',
      title: 'Live Doubt Solving Session',
      description: 'Ask your doubts in real-time',
      teacherId: '2',
      teacherName: 'Priya Sharma',
      type: CourseType.live,
      durationMinutes: 60,
      subject: 'Mathematics',
      classLevel: 'Class 10',
      tags: ['Doubt Solving', 'Live'],
      createdAt: DateTime.now(),
      scheduledAt: DateTime.now().add(const Duration(hours: 2)),
      viewCount: 0,
      rating: 0.0,
    ),
  ];

  // Mock Tests
  static final List<TestModel> mockTests = [
    TestModel(
      id: '1',
      title: 'Daily Math Quiz',
      description: 'Test your daily math skills',
      type: TestType.daily,
      subject: 'Mathematics',
      classLevel: 'Class 10',
      questions: [
        QuestionModel(
          id: 'q1',
          question: 'What is the value of x in 2x + 5 = 15?',
          options: ['5', '10', '7.5', '2.5'],
          correctAnswerIndex: 0,
          explanation: '2x = 15 - 5 = 10, so x = 5',
          marks: 1,
        ),
        QuestionModel(
          id: 'q2',
          question: 'What is the square root of 144?',
          options: ['10', '11', '12', '13'],
          correctAnswerIndex: 2,
          explanation: '12 × 12 = 144',
          marks: 1,
        ),
      ],
      durationMinutes: 30,
      totalMarks: 2,
      createdAt: DateTime.now(),
      isActive: true,
    ),
  ];

  // Mock Wallet
  static WalletModel getMockWallet(String userId) {
    return WalletModel(
      userId: userId,
      balance: 500.0,
      rewardPoints: 1250,
      transactions: [
        TransactionModel(
          id: 't1',
          type: TransactionType.credit,
          amount: 500.0,
          description: 'Wallet Recharge',
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
        ),
        TransactionModel(
          id: 't2',
          type: TransactionType.debit,
          amount: 50.0,
          description: 'Emergency Doubt - Mathematics',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
      lastUpdated: DateTime.now(),
    );
  }

  // Mock Rewards
  static List<RewardModel> getMockRewards(String userId) {
    return [
      RewardModel(
        id: 'r1',
        userId: userId,
        type: RewardType.dailyLogin,
        points: 10,
        description: 'Daily login bonus',
        earnedAt: DateTime.now(),
      ),
      RewardModel(
        id: 'r2',
        userId: userId,
        type: RewardType.videoCompletion,
        points: 20,
        description: 'Completed: Quadratic Equations',
        earnedAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }

  // Mock Streak
  static StreakModel getMockStreak(String userId) {
    return StreakModel(
      userId: userId,
      currentStreak: 7,
      longestStreak: 15,
      lastActivityDate: DateTime.now(),
      activityDates: List.generate(
        7,
        (index) => DateTime.now().subtract(Duration(days: index)),
      ),
    );
  }
}
