import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../data/sources/mock_data_source.dart';
import '../../data/models/wallet_model.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = MockDataSource.getMockWallet('1');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Show transaction history
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Card
          CustomCard(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.walletGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 32,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'VLM Wallet',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Available Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Formatters.currency(wallet.balance),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Recharge',
                          onPressed: () {
                            _showRechargeDialog(context);
                          },
                          type: ButtonType.secondary,
                          icon: Icons.add,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Transfer',
                          onPressed: () {},
                          type: ButtonType.outline,
                          icon: Icons.send,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Reward Points Card
          CustomCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppColors.rewardGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.stars,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reward Points', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${wallet.rewardPoints} points',
                        style: AppTextStyles.h5.copyWith(color: AppColors.rewardGold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '≈ ${Formatters.currency(wallet.pointsInRupees)}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: 'Convert',
                  onPressed: () {},
                  size: ButtonSize.small,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Recent Transactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions', style: AppTextStyles.h5),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomCard(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: wallet.transactions.map((transaction) {
                return _buildTransactionItem(transaction);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction) {
    final isCredit = transaction.type == TransactionType.credit;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isCredit ? AppColors.success : AppColors.error).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? AppColors.success : AppColors.error,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.description, style: AppTextStyles.labelMedium),
                const SizedBox(height: 4),
                Text(
                  Formatters.date(transaction.timestamp),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '-'} ${Formatters.currency(transaction.amount)}',
            style: AppTextStyles.labelLarge.copyWith(
              color: isCredit ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showRechargeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recharge Wallet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRechargeOption(context, '₹100'),
            _buildRechargeOption(context, '₹500'),
            _buildRechargeOption(context, '₹1000'),
            _buildRechargeOption(context, '₹2000'),
          ],
        ),
      ),
    );
  }

  Widget _buildRechargeOption(BuildContext context, String amount) {
    return ListTile(
      title: Text(amount, style: AppTextStyles.labelLarge),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
        // Process recharge
      },
    );
  }
}
