import 'package:hive_ce/hive.dart';
import 'package:torneios_app/src/models/match.dart';
import 'package:torneios_app/src/models/tournament.dart';

part 'round.g.dart';

@HiveType(typeId: 2)
class Round extends HiveObject {
  @HiveField(0)
  final int index;

  @HiveField(1)
  final HiveList<Match> matches;

  Round({
    required this.index,
    required this.matches,
  });
}
