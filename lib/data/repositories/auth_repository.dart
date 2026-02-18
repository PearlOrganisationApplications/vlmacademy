import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> login(String emailOrPhone, String password);
  Future<bool> sendOTP(String phoneOrEmail);
  Future<UserModel?> verifyOTP(String phoneOrEmail, String otp);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<bool> updateProfile(UserModel user);
}
