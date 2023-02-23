import 'dart:convert';

import 'package:inventaverse_trainer/models/user_possessions.dart';

class UserProfile {
  String displayName;
  String groupName;
  String home;
  String mapId;
  UserPossessions possessions;
  int profilePicture;

  UserProfile(
      {required this.displayName,
      required this.groupName,
      required this.home,
      required this.mapId,
      required this.possessions,
      required this.profilePicture});

  UserProfile.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'] ?? "",
        groupName = json['groupName'] ?? "",
        home = json['home'] ?? "",
        mapId = json['mapId'] ?? "",
        possessions = UserPossessions.fromJson(jsonDecode(json['possessions'])),
        profilePicture = json['profilePicture'] ?? -1;

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'groupName': groupName,
      'home': home,
      'mapId': mapId,
      'possessions': jsonEncode(possessions),
      'profilePicture': profilePicture
    };
  }
}
