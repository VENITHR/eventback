import 'dart:developer';
import 'package:bookevent/core/CustomeDateFormat.dart';
import 'package:flutter/material.dart';

import 'dashboard_repo.dart';

class DashboardProvider extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Map<String, dynamic>> eventList = [];
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  DashboardProvider() {
    setSelectedDay(DateTime.now());
  }
  void setSelectedDay(DateTime selectedDay) async {
    _selectedDay = selectedDay;
    try {
      var response = await DashboardRepo().eventList(
          CustomDateFormat().formattedDate(DateTime.now()),
          CustomDateFormat().formattedDate(_selectedDay!));
      eventList = List<Map<String, dynamic>>.from(response['data']);
      log(eventList.toString());
    } catch (e) {
      log('Error fetching events: $e');
    }
    notifyListeners();
  }

  void setFocusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    log('Focused: $_focusedDay');
    notifyListeners();
  }

  void toggleBooked(int index) {
    eventList[index]['is_booked'] = !eventList[index]['is_booked'];
    notifyListeners();
  }

  Future<void> toggleFavorite(int index) async {
    var response = await DashboardRepo().makeFavorites(eventList[index]['id']);
    setSelectedDay(_selectedDay!);
    eventList[index]['is_favorited'] = !eventList[index]['is_favorited'];
    notifyListeners();
  }
}
