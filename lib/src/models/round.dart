import 'package:hive_ce/hive.dart';
import 'package:torneios_app/src/models/match.dart';
import 'package:torneios_app/src/models/team.dart';
import 'package:torneios_app/src/models/tournament.dart';

part 'round.g.dart';

@HiveType(typeId: 2)
class Round extends HiveObject {
  @HiveField(0)
  final int index;

  @HiveField(1)
  final HiveList<Match> matches;

  @HiveField(2)
  bool locked;

  bool get matchesConcluded {
    return matches.every((match) => match.team1 != null && match.team2 != null);
  }

  List<Team> get winners => matches.fold([], (allWinners, match) {
        if (match.winner != null) {
          allWinners.add(match.winner!);
        }

        return allWinners;
      });

  void lock() {
    if (locked) return;

    if (!matchesConcluded) {
      throw Exception("A rodada não pode ser bloqueada pois não está finalizada");
    }

    locked = true;
  }

  Round({
    required this.index,
    required this.matches,
    this.locked = false,
  });
}
