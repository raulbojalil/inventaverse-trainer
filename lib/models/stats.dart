class Stats {
  int k;
  int e;
  int d;
  int t;
  int r;
  int w;
  int c;

  Stats({
    required this.k,
    required this.e,
    required this.d,
    required this.t,
    required this.r,
    required this.w,
    required this.c,
  });

  Stats.fromJson(Map<String, dynamic> json)
      : k = json["k"] ?? 0,
        e = json["e"] ?? 0,
        d = json["d"] ?? 0,
        t = json["t"] ?? 0,
        r = json["r"] ?? 0,
        w = json["w"] ?? 0,
        c = json["c"] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'k': k,
      'e': e,
      'd': d,
      't': t,
      'r': r,
      'w': w,
      'c': c,
    };
  }
}
