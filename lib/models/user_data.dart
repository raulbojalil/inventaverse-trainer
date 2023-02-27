import 'package:inventaverse_trainer/models/user_profile.dart';

class UserData {
  String localId;
  String userId;
  String cookie;
  bool unlockAllCharacters;
  bool unlockAllArtifacts;
  bool unlockAllMagicBooks;
  UserProfile userProfile;

  UserData(
      {required this.localId,
      required this.userId,
      required this.cookie,
      required this.unlockAllArtifacts,
      required this.unlockAllCharacters,
      required this.unlockAllMagicBooks,
      required this.userProfile});

  UserData.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] ?? "",
        localId = json['localId'] ?? "",
        cookie = json['cookie'] ?? "",
        unlockAllArtifacts = json['unlockAllArtifacts'] ?? "",
        unlockAllCharacters = json['unlockAllCharacters'] ?? "",
        unlockAllMagicBooks = json['unlockAllMagicBooks'] ?? "",
        userProfile = UserProfile.fromJson(json['userProfile']);

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'localId': localId,
      'cookie': cookie,
      'unlockAllArtifacts': unlockAllArtifacts,
      'unlockAllCharacters': unlockAllCharacters,
      'unlockAllMagicBooks': unlockAllMagicBooks,
      'userProfile': userProfile
    };
  }
}
