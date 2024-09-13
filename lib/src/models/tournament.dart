import 'dart:math';

import 'package:hive_ce/hive.dart';
import '../../main.dart';
import 'round.dart';
import 'team.dart';
import 'match.dart';
import '../shared/utils.dart';

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
  bool isActive;

  @HiveField(5)
  final HiveList<Team> teams;

  @HiveField(6)
  final HiveList<Round> rounds;

  @HiveField(7)
  final String? address;

  @HiveField(8)
  final String? geolocation;

  Team? get winner {
    if (rounds.isEmpty) return null;

    final finalRound = rounds.where((element) => element.index == 1).first;

    if (!finalRound.locked) return null;
    if (finalRound.winners.isEmpty) return null;

    return finalRound.winners.first;
  }

  Future<void> start() async {
    final teamCount = teams.length;

    assert(isPowerOfTwo(teamCount),
        "O torneio deve ter um número de equipes adequado. Edite o número de equipes e tente novamente.");

    // equivalent to log2(teamCount)
    //
    // teamCount | log2(teamCount)
    // ----------|-----------------
    // 2 teams   | 1 round            (1 vs 2)
    // 4 teams   | 3 rounds           (1 vs 2) > (1 vs 3) < (3 vs 4))
    // 8 teams   | 2 rounds           (1 vs 2, 3 vs 4) > (1 vs 3) > (1 vs 5) < (5 vs 7) < (5 vs 6, 7 vs 8)
    // 16 teams  | 4 rounds           ....
    final roundsNumber = (log(teamCount) * log2e).round();

    final roundBox = Hive.box<Round>(roundsBox);
    final matchBox = Hive.box<Match>(matchesBox);

    // Delete all current rounds
    for (var i = 0; i < rounds.length; i++) {
      rounds[i].delete();
    }

    // generate new rounds
    for (var i = 0; i < roundsNumber; i++) {
      final index = i + 1;
      final round = Round(
        index: index,
        matches: HiveList(matchBox)
          ..addAll(
            List.generate(
              pow(2, index - 1).toInt(),
              (_) {
                final match = Match(
                  score1: 0,
                  score2: 0,
                  team1: null,
                  team2: null,
                );

                matchBox.add(match);

                return match;
              },
            ),
          ),
      );
      await roundBox.add(round);

      rounds.add(round);
    }

    isActive = true;
  }

  Tournament({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.isActive,
    required this.teams,
    required this.rounds,
    this.address,
    this.geolocation,
  });
}
