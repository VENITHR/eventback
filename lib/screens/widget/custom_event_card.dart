import 'package:flutter/material.dart';

class CustomEventCard extends StatelessWidget {
  final String title;
  final String date;
  final bool isFavorite;
  final bool isBooked;
  final String favCount;
  final String bookedCount;
  final VoidCallback? onTap;
  final bool? isSuffixIconNeed;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onBookedToggle;

  const CustomEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.favCount,
    required this.bookedCount,
    this.isFavorite = false,
    this.isBooked = false,
    this.isSuffixIconNeed = true,
    this.onTap,
    this.onFavoriteToggle,
    this.onBookedToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade50,
          child: Icon(Icons.event, color: Colors.orange),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          date,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSuffixIconNeed == true)
              _buildIconWithCount(
                icon: isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : Colors.grey,
                count: favCount,
                onPressed: onFavoriteToggle,
              ),
            if (isSuffixIconNeed == true) const SizedBox(width: 12),
            if (isSuffixIconNeed == true)
              _buildIconWithCount(
                icon:
                    isBooked ? Icons.check_circle : Icons.check_circle_outline,
                color: isBooked ? Colors.green : Colors.grey,
                count: bookedCount,
                onPressed: onBookedToggle,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCount({
    required IconData icon,
    required Color color,
    required String count,
    VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(icon, color: color, size: 22), // smaller than IconButton
        ),
        const SizedBox(height: 2),
        Text(
          count,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
