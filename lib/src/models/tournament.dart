import 'package:hive_ce/hive.dart';
import 'package:torneios_app/src/models/round.dart';
import 'package:torneios_app/src/models/team.dart';

part 'tournament.g.dart';

@HiveType(typeId: 0)
class Tournament extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final bool isActive;

  @HiveField(5)
  final HiveList<Team> teams;

  @HiveField(6)
  final HiveList<Round> rounds;

  Tournament({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.isActive,
    required this.teams,
    required this.rounds,
  });
}
