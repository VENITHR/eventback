import 'package:bookevent/screens/Dashboard/dashboard_repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailBottomSheet extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailBottomSheet({super.key, required this.event});

  String formatDateTime(String dateTime) {
    final dt = DateTime.parse(dateTime).toLocal();
    return DateFormat("EEEE, MMM d, yyyy • h:mm a").format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 60,
                height: 6,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Title
            Text(
              event['title'] ?? "Event Title",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              event['description'] ?? "",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),

            // Date & Time
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.pink),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "${formatDateTime(event['start_time'])} - ${DateFormat("h:mm a").format(DateTime.parse(event['end_time']).toLocal())}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Location
            Row(
              children: [
                const Icon(Icons.map, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    event['location'] ?? "Unknown Location",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats (Favorites & Booked)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red),
                    const SizedBox(width: 6),
                    Text("${event['favorited_count']} favorited"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.airplane_ticket, color: Colors.green),
                    const SizedBox(width: 6),
                    Text("${event['booked_count']} booked"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  var response = await DashboardRepo().bookEvent(event['id']);
                  Navigator.pop(context); // close sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Event Booked Successfully")),
                  );
                },
                child: const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
