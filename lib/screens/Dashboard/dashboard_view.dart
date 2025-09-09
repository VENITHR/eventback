import 'dart:developer';

import 'package:bookevent/app_theme.dart';
import 'package:bookevent/core/CustomeDateFormat.dart';
import 'package:bookevent/core/navigation_service.dart';
import 'package:bookevent/screens/widget/custom_event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widget/EventDetailBottomSheet.dart';
import 'dashboard_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: provider.focusedDay,
              selectedDayPredicate: (day) =>
                  isSameDay(provider.selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                provider.setSelectedDay(selectedDay);
                provider.setFocusedDay(focusedDay);
              },
              onPageChanged: (focusedDay) {
                provider.setFocusedDay(focusedDay);
              },
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.eventList.length,
                    itemBuilder: (context, index) {
                      final event = provider.eventList[index];
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                EventDetailBottomSheet(event: event),
                          );
                        },
                        child: CustomEventCard(
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FAB pressed!");
          NavigationService.pushNamed('/CreateEventView');
        },
        backgroundColor: AppTheme.primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
