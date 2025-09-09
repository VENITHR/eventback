import 'dart:developer';
import 'package:bookevent/core/CustomeDateFormat.dart';
import 'package:bookevent/screens/FavoriteList/favorite_list_repo.dart';
import 'package:flutter/material.dart';

class FavoriteListProvider extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Map<String, dynamic>> eventList = [];
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  FavoriteListProvider() {
    setSelectedDay(DateTime.now());
  }

  void setSelectedDay(DateTime selectedDay) async {
    _selectedDay = selectedDay;
    try {
      var response = await FavoriteListRepo().eventList(
          CustomDateFormat().formattedDate(DateTime.now()),
          CustomDateFormat().formattedDate(_selectedDay!));
      var sampleFavoriteList =
          List<Map<String, dynamic>>.from(response['data']);
      eventList =
          sampleFavoriteList.where((x) => x['is_favorited'] == true).toList();
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
    eventList[index]['isBooked'] = !eventList[index]['isBooked'];
    notifyListeners();
  }

  void toggleFavorite(int index) {
    eventList[index]['isFavorited'] = !eventList[index]['isFavorited'];
    notifyListeners();
  }
}
