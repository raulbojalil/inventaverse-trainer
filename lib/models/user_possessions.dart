import 'dart:convert';
import 'dart:core';
import 'dart:html';

import 'package:inventaverse_trainer/models/stats.dart';
import 'package:inventaverse_trainer/models/treasure.dart';

class UserPossessions {
  List<int> artifacts;
  List<String> incantations;
  List<int> fighters;
  List<int> owned;
  int mentor;
  int progress;
  List<int> skills;
  List<int> magics;
  List<int> fleet;
  Treasure treasure;
  List<int> mazes;
  List<String> history;
  List<int> puzzlesA;
  Stats stats;

  UserPossessions(
      {required this.artifacts,
      required this.incantations,
      required this.fighters,
      required this.owned,
      required this.mentor,
      required this.progress,
      required this.skills,
      required this.magics,
      required this.fleet,
      required this.treasure,
      required this.mazes,
      required this.puzzlesA,
      required this.history,
      required this.stats});

//\"stats\":{\"k\":500,\"e\":200,\"d\":252,\"t\":1,\"r\":2,\"w\":7,\"c\":24},\"fleet\":[0],\"puzzles[A\":[1659537892263],\"mazes\":[1673362333676,1673314351257],\"history\":[{\"W\":1674166802618,\"I\":\"-NJhXA6pKlHd7Qy7p4yQ\"}]

  UserPossessions.fromJson(Map<String, dynamic> json)
      : artifacts =
            (json['artifacts'] as List<dynamic>).map((e) => e as int).toList(),
        incantations = (json['incantations'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        fighters =
            (json['fighters'] as List<dynamic>).map((e) => e as int).toList(),
        fleet = (json['fleet'] as List<dynamic>).map((e) => e as int).toList(),
        owned = (json['owned'] as List<dynamic>).map((e) => e as int).toList(),
        skills =
            (json['skills'] as List<dynamic>).map((e) => e as int).toList(),
        magics =
            (json['magics'] as List<dynamic>).map((e) => e as int).toList(),
        mazes = (json['mazes'] as List<dynamic>).map((e) => e as int).toList(),
        mentor = json["mentor"] ?? 1,
        treasure = Treasure.fromJson(json["treasure"] ?? "{ }"),
        progress = json["progress"] ?? 0,
        puzzlesA =
            (json['puzzles[A'] as List<dynamic>).map((e) => e as int).toList(),
        history = [],
        stats = Stats.fromJson(json["stats"]);

  Map<String, dynamic> toJson() {
    return {
      'artifacts': artifacts,
      'incantations': incantations,
      'fighters': fighters,
      'owned': owned,
      'mazes': mazes,
      'mentor': mentor,
      'progress': progress,
      'skills': skills,
      'magics': magics,
      'treasure': treasure,
      'fleet': fleet,
      'puzzles[A': puzzlesA,
      'history': history,
      'stats': stats
    };
  }
}
