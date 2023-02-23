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
  Treasure treasure;
  Stats stats;

  dynamic fleet;
  dynamic mazes;
  dynamic history;
  dynamic puzzles;
  dynamic loadouts;
  dynamic campaign;
  dynamic sets;

  UserPossessions({
    required this.artifacts,
    required this.incantations,
    required this.fighters,
    required this.owned,
    required this.mentor,
    required this.progress,
    required this.skills,
    required this.magics,
    required this.fleet,
    required this.treasure,
    required this.stats,
    required this.mazes,
    required this.history,
    required this.puzzles,
    required this.loadouts,
    required this.campaign,
    required this.sets,
  });

  UserPossessions.fromJson(Map<String, dynamic> json)
      : artifacts = json['artifacts'] != null
            ? (json['artifacts'] as List<dynamic>).map((e) => e as int).toList()
            : [],
        incantations = json['incantations'] != null
            ? (json['incantations'] as List<dynamic>)
                .map((e) => e as String)
                .toList()
            : [],
        fighters = json['fighters'] != null
            ? (json['fighters'] as List<dynamic>).map((e) => e as int).toList()
            : [],
        owned = json['owned'] != null
            ? (json['owned'] as List<dynamic>).map((e) => e as int).toList()
            : [],
        skills = json['skills'] != null
            ? (json['skills'] as List<dynamic>).map((e) => e as int).toList()
            : [],
        magics = json["magics"] != null
            ? (json['magics'] as List<dynamic>).map((e) => e as int).toList()
            : [],
        mentor = json["mentor"] ?? 1,
        treasure = Treasure.fromJson(json["treasure"] ?? "{ }"),
        progress = json["progress"] ?? 0,
        mazes = json["mazes"] != null ? json["mazes"] : [],
        fleet = json["fleet"] != null ? json["fleet"] : [],
        loadouts = json["loadouts"] != null ? json["loadouts"] : [],
        puzzles = json["puzzles"] != null ? json["puzzles"] : [],
        history = json["history"] != null ? json["history"] : [],
        campaign = json["campaign"] != null ? json["campaign"] : [],
        sets = json["sets"] != null ? json["sets"] : [],
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
      'puzzles': puzzles,
      'history': history,
      'loadouts': loadouts,
      'campaign': campaign,
      'sets': sets,
      'stats': stats
    };
  }
}
