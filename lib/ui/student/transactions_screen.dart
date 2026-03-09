import 'package:flutter/material.dart';
import 'receipt_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color accentBlue = Color(0xFF3B82F6);
    const Color textBody = Color(0xFF94A3B8);

    final List<Map<String, String>> transactions = [
      {
        'title': 'Mathematics',
        'subtitle': 'Trigonometry',
        'image': 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb',
      },
      {
        'title': 'Sinhala',
        'subtitle': 'Grammar',
        'image': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f',
      },
      {
        'title': 'English',
        'subtitle': 'Tenses',
        'image': 'https://images.unsplash.com/photo-1516979187457-637abb4f9353',
      },
      {
        'title': 'Science',
        'subtitle': 'Chemistry',
        'image': 'https://images.unsplash.com/photo-1532094349884-543bc11b234d',
      },
      {
        'title': 'History',
        'subtitle': 'World war 2',
        'image': 'https://images.unsplash.com/photo-1461360370896-922624d12aa1',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Transaction History",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight
                  .w600), // Assuming AppTextStyles.h5 is equivalent to this
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgimage.png',
              fit: BoxFit.cover,
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: transactions.length,
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.white12, height: 1),
            itemBuilder: (context, index) {
              final item = transactions[index];
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                leading: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  item['title']!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      item['subtitle']!,
                      style: const TextStyle(color: textBody, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Paid',
                        style: TextStyle(
                            color: accentBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => ReceiptScreen(
                        courseName: item['title']!,
                        category: item['subtitle']!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
