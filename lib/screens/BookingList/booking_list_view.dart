import 'package:bookevent/app_theme.dart';
import 'package:bookevent/core/CustomeDateFormat.dart';
import 'package:bookevent/screens/widget/custom_event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'booking_List_provider.dart';

class BookingListView extends StatelessWidget {
  const BookingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
      ),
      body: provider.eventList.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_add,
                    color: AppTheme.primaryColor,
                    size: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Booking List Is Empty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.eventList.length,
                    itemBuilder: (context, index) {
                      final event = provider.eventList[index];
                      return CustomEventCard(
                          title: event['title'],
                          date:
                              "Start : ${CustomDateFormat().formatUtcToLocal(event['start_time'])}\nEnd : ${CustomDateFormat().formatUtcToLocal(event['end_time'])}",
                          favCount: event['favorited_count'].toString(),
                          bookedCount: event['booked_count'].toString(),
                          isFavorite: event['is_favorited'] ?? false,
                          isBooked: event['is_booked'] ?? false,
                          onFavoriteToggle: () =>
                              provider.toggleFavorite(index),
                          onBookedToggle: () => provider.toggleBooked(index),
                          isSuffixIconNeed: false);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
