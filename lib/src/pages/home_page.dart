import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:torneios_app/main.dart';
// import 'package:torneios_app/src/widgets/form_dialog.dart';
import 'package:torneios_app/src/widgets/tournament_card.dart';
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
              box.add(
                Tournament(
                  name: "Nome",
                  description: "Descrição",
                  imagePath: "",
                  isActive: false,
                  rounds: HiveList(box),
                  teams: HiveList(box),
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
