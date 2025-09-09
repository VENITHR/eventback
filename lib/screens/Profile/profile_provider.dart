import 'package:bookevent/screens/Profile/profile_repo.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic> eventList = {};
  ProfileProvider() {
    fetchProfileDetails();
  }

  fetchProfileDetails() async {
    try {
      var response = await ProfileRepo().getProfile();
    } catch (e) {
      print(e);
    }
  }
}
