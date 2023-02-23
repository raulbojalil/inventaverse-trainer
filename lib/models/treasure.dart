class Treasure {
  int commendations;
  int gold;
  int inceptium;

  Treasure({
    required this.commendations,
    required this.gold,
    required this.inceptium,
  });

  Treasure.fromJson(Map<String, dynamic> json)
      : gold = json["gold"] ?? 0,
        commendations = json["commendations"] ?? 0,
        inceptium = json["inceptium"] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'commendations': commendations,
      'gold': gold,
      'inceptium': inceptium
    };
  }
}
