import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventaverse_trainer/models/user_data.dart';

import '../models/user_profile.dart';

class UsersApi {
  static Future<int> updateUser(UserData userData) async {
    var url = Uri.parse(
        'https://faas-sfo3-7872a1dd.doserverless.co/api/v1/web/fn-e0a7786b-ff1f-4c30-a9cb-ee93e1271573/Inventaverse/updateUser');

    if (userData.unlockAllArtifacts) {
      userData.userProfile.possessions.artifacts = [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30
      ];
    }

    if (userData.unlockAllCharacters) {
      userData.userProfile.possessions.fighters = [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30
      ];
    }

    if (userData.unlockAllMagicBooks) {
      userData.userProfile.possessions.magics = [0, 1, 2];
    }

    var req = http.Request('POST', url);
    req.body = jsonEncode(userData);
    final res = await req.send();

    var response = json.decode(await res.stream.bytesToString());
    return response["responseStatus"] ?? 0;
  }

  static Future<UserProfile> getUser(String id, String cookie) async {
    var url = Uri.parse(
        'https://faas-sfo3-7872a1dd.doserverless.co/api/v1/web/fn-e0a7786b-ff1f-4c30-a9cb-ee93e1271573/Inventaverse/getUser');

    var req = http.Request('POST', url);
    req.body = "{ \"userId\": \"$id\", \"cookie\": \"$cookie\" }";

    final res = await req.send();

    var response = json.decode(await res.stream.bytesToString());

    if (response["error"] == true) {
      throw "Error";
    }

    return UserProfile.fromJson(response["data"]);
  }
}
