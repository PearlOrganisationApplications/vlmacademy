import '../models/wallet_model.dart';

abstract class WalletRepository {
  Future<WalletModel?> getWallet(String userId);
  Future<bool> rechargeWallet(String userId, double amount);
  Future<bool> deductFromWallet(String userId, double amount, String description);
  Future<bool> addRewardPoints(String userId, int points, String description);
  Future<bool> convertPointsToRupees(String userId, int points);
  Future<List<TransactionModel>> getTransactions(String userId);
}
