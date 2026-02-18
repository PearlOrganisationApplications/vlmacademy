enum TransactionType { credit, debit }

class TransactionModel {
  final String id;
  final TransactionType type;
  final double amount;
  final String description;
  final DateTime timestamp;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == 'TransactionType.${json['type']}',
      ),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'amount': amount,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class WalletModel {
  final String userId;
  final double balance;
  final int rewardPoints;
  final List<TransactionModel> transactions;
  final DateTime lastUpdated;

  WalletModel({
    required this.userId,
    required this.balance,
    required this.rewardPoints,
    required this.transactions,
    required this.lastUpdated,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      userId: json['userId'] as String,
      balance: (json['balance'] as num).toDouble(),
      rewardPoints: json['rewardPoints'] as int,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'balance': balance,
      'rewardPoints': rewardPoints,
      'transactions': transactions.map((e) => e.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  WalletModel copyWith({
    String? userId,
    double? balance,
    int? rewardPoints,
    List<TransactionModel>? transactions,
    DateTime? lastUpdated,
  }) {
    return WalletModel(
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      transactions: transactions ?? this.transactions,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  // Convert points to rupees
  double get pointsInRupees => rewardPoints / 10.0;
}
