import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
// import 'package:torneios_app/src/widgets/form_dialog.dart';
import 'package:torneios_app/src/widgets/tournament_card.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../models/round.dart';
import '../models/team.dart';
import '../models/tournament.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: Hive.box<Tournament>(tournamentsBox).listenable(),
      builder: (context, Box<Tournament> box, widget) {
        final tournaments = box.values.toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('TORNEIOS'),
            centerTitle: true,
            elevation: 1,
            shape: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: tournaments.length,
            itemBuilder: (context, index) {
              final tournament = tournaments[index];

              return TournamentCard(tournament: tournament);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              final teamBox = Hive.box<Team>(teamsBox);
              final roundBox = Hive.box<Round>(roundsBox);

              box.add(
                Tournament(
                  id: const Uuid().v4(),
                  name: faker.company.name(),
                  description: faker.lorem.sentence(),
                  imagePath: faker.image.loremPicsum(),
                  isActive: false,
                  rounds: HiveList(roundBox),
                  teams: HiveList(teamBox),
                ),
              );
            },
            label: const Text("Novo"),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
