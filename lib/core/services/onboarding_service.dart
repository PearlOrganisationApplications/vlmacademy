import 'package:shared_preferences/shared_preferences.dart';

enum TeacherOnboardingStep { signup, documents, interview, review, completed }

class OnboardingService {
  static const String _kCurrentStepKey = 'teacher_onboarding_step';
  static const String _kTeacherIdKey = 'teacher_id';
  static const String _kInterviewDateKey = 'interview_date';
  static const String _kInterviewTimeKey = 'interview_time';
  static const String _kDocDegreeKey = 'doc_degree';
  static const String _kDocIdentityKey = 'doc_identity';
  static const String _kDocExperienceKey = 'doc_experience';

  final SharedPreferences _prefs;

  OnboardingService(this._prefs);

  static Future<OnboardingService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return OnboardingService(prefs);
  }

  TeacherOnboardingStep get currentStep {
    final stepIndex = _prefs.getInt(_kCurrentStepKey) ?? 0;
    return TeacherOnboardingStep.values[stepIndex];
  }

  Future<void> setCurrentStep(TeacherOnboardingStep step) async {
    await _prefs.setInt(_kCurrentStepKey, step.index);
  }

  String get teacherId => _prefs.getString(_kTeacherIdKey) ?? 'AVER-99201';

  Future<void> setTeacherId(String id) async {
    await _prefs.setString(_kTeacherIdKey, id);
  }

  String? get interviewDate => _prefs.getString(_kInterviewDateKey);
  String? get interviewTime => _prefs.getString(_kInterviewTimeKey);

  Future<void> setInterviewDetails(String date, String time) async {
    await _prefs.setString(_kInterviewDateKey, date);
    await _prefs.setString(_kInterviewTimeKey, time);
  }

  // Document management (String lists of file paths)
  List<String> getDocuments(String category) {
    return _prefs.getStringList(_getDocKey(category)) ?? [];
  }

  Future<void> addDocument(String category, String path) async {
    final current = getDocuments(category);
    if (!current.contains(path)) {
      current.add(path);
      await _prefs.setStringList(_getDocKey(category), current);
    }
  }

  Future<void> removeDocument(String category, String path) async {
    final current = getDocuments(category);
    current.remove(path);
    await _prefs.setStringList(_getDocKey(category), current);
  }

  String _getDocKey(String category) {
    switch (category) {
      case 'degree':
        return _kDocDegreeKey;
      case 'identity':
        return _kDocIdentityKey;
      case 'experience':
        return _kDocExperienceKey;
      default:
        return 'doc_$category';
    }
  }

  Future<void> clear() async {
    await _prefs.remove(_kCurrentStepKey);
    await _prefs.remove(_kTeacherIdKey);
    await _prefs.remove(_kInterviewDateKey);
    await _prefs.remove(_kInterviewTimeKey);
    await _prefs.remove(_kDocDegreeKey);
    await _prefs.remove(_kDocIdentityKey);
    await _prefs.remove(_kDocExperienceKey);
  }

  bool get isOnboardingComplete =>
      currentStep == TeacherOnboardingStep.completed;
}
