import 'package:intl/intl.dart';

class Formatters {
  // Currency Formatter (Indian Rupees)
  static String currency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Currency with Decimals
  static String currencyWithDecimals(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  // Date Formatter (dd MMM yyyy)
  static String date(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Date with Time (dd MMM yyyy, hh:mm a)
  static String dateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  // Time Only (hh:mm a)
  static String time(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Relative Time (e.g., "2 hours ago")
  static String relativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return date(dateTime);
    }
  }

  // Duration Formatter (e.g., "1h 30m")
  static String duration(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    }
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) {
      return '${hours}h';
    }
    return '${hours}h ${mins}m';
  }

  // Compact Number (e.g., 1.2K, 1.5M)
  static String compactNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
  }

  // Phone Number Formatter (e.g., +91 98765 43210)
  static String phoneNumber(String phone) {
    if (phone.length == 10) {
      return '+91 ${phone.substring(0, 5)} ${phone.substring(5)}';
    }
    return phone;
  }

  // Percentage Formatter
  static String percentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }
}
