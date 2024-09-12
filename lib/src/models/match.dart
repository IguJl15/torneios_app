import 'dart:convert';

import 'package:hive_ce/hive.dart';

import 'team.dart';

part 'match.g.dart';

@HiveType(typeId: 3)
class Match extends HiveObject {
  @HiveField(0)
  Team? team1;
  @HiveField(1)
  Team? team2;
  @HiveField(2)
  int score1;
  @HiveField(3)
  int score2;
  Team? get winner {
    if (!isValid) return null;

    if (score1 > score2) {
      return team1;
    } else if (score1 < score2) {
      return team2;
    }

    return null;
  }

  bool get isValid => team1 != null && team2 != null;

  Match({
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
  });

  @override
  String toString() {
    return 'Match(team1: $team1, team2: $team2, score1: $score1, score2: $score2)';
  }
}
