import '../models/test_model.dart';

abstract class TestRepository {
  Future<List<TestModel>> getTests({String? subject, String? classLevel, TestType? type});
  Future<TestModel?> getTestById(String id);
  Future<bool> submitTest(String testId, String userId, Map<String, int> answers, int timeTakenMinutes);
  Future<TestResultModel?> getTestResult(String testId, String userId);
  Future<List<TestResultModel>> getUserTestHistory(String userId);
}
