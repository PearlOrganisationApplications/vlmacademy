import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  final String courseName;
  final String category;

  const ReceiptScreen({
    super.key,
    required this.courseName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF030712);
    const Color accentBlue = Color(0xFF3B82F6);
    const Color textBody = Color(0xFF94A3B8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'E-Receipt',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded, color: Colors.white70),
            onPressed: () => _showOptionsOverlay(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Receipt Illustration
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.description_rounded,
                          size: 40, color: Colors.white24),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: accentBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Details
            _buildInfoRow('Name', 'Harsha', textBody),
            _buildInfoRow('Email ID', 'harshaKumara@gmail.com', textBody),
            _buildInfoRow('Course', courseName, textBody),
            _buildInfoRow('Category', category, textBody),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: Colors.white10),
            ),
            _buildInfoRow('TransactionID', 'SK345680976', textBody,
                showCopy: true),
            _buildInfoRow('Price', '799/-', textBody),
            _buildInfoRow('Date', 'JAN 20, 2025  /  15:45', textBody),
            _buildInfoRow('Status', 'Paid', textBody, isStatus: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color textBody,
      {bool showCopy = false, bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                color: textBody, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              if (isStatus)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Paid',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                )
              else
                Text(
                  value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              if (showCopy) ...[
                const SizedBox(width: 8),
                const Icon(Icons.copy_rounded, size: 14, color: Colors.white70),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showOptionsOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 80, right: 20),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildOverlayItem(Icons.share_outlined, 'Share',
                        () => Navigator.pop(context)),
                    _buildOverlayItem(Icons.download_outlined, 'Download',
                        () => Navigator.pop(context)),
                    _buildOverlayItem(Icons.print_outlined, 'Print',
                        () => Navigator.pop(context)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverlayItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.white, size: 18),
      title: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
