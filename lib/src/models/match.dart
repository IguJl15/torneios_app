import 'package:hive_ce/hive.dart';
import 'package:torneios_app/src/models/team.dart';

part 'match.g.dart';

@HiveType(typeId: 3)
class Match extends HiveObject {
  @HiveField(0)
  final Team team1;
  @HiveField(1)
  final Team team2;
  @HiveField(2)
  final int score1;
  @HiveField(3)
  final int score2;

  @HiveField(4)
  final bool finished;

  Match({
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
    required this.finished,
  });
}
