import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:torneios_app/main.dart';
import 'package:torneios_app/src/pages/location_page.dart';
import 'package:torneios_app/src/pages/rounds_page.dart';
// import 'package:torneios_app/src/pages/location_page.dart';
import 'package:torneios_app/src/pages/teams_page.dart';
import 'package:torneios_app/src/widgets/tournament_list_item.dart';

import '../models/tournament.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({super.key, required this.tournament});
  final Tournament tournament;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: Hive.box<Tournament>(tournamentsBox).listenable(),
      builder: (context, _, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tournament.name),
            centerTitle: true,
            shape: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: tournament.isActive
                ? null
                : () async {
                    showAdaptiveDialog(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text("Iniciar Torneio"),
                          content: const Text(
                              "Tem certeza que deseja marcar este torneio como iniciado? As equipes não poderão ser editadas após o início do torneio."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await tournament.start();
                                await tournament.save();

                                if (dialogContext.mounted) Navigator.pop(dialogContext);
                              },
                              child: const Text("Iniciar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
            label: Text(tournament.isActive ? "Torneio iniciado" : "Iniciar Torneio"),
            icon: tournament.isActive ? null : const Icon(Icons.play_arrow),
          ),
          body: ListView(
            padding: const EdgeInsets.all(4),
            children: [
              TournamentListItem(
                text: "Equipes",
                icon: Icons.groups,
                pageBuilder: (_) => TeamsPage(tournament: tournament),
                route: '/equipes',
              ),
              TournamentListItem(
                text: "Rodadas",
                icon: Icons.web,
                pageBuilder: (_) => RoundsPage(tournament: tournament),
                route: '/rodadas',
              ),
              TournamentListItem(
                text: "Localização",
                icon: Icons.location_on,
                pageBuilder: (_) => LocationPage(tournament: tournament),
                route: '/location ',
              ),
            ],
          ),
        );
      },
    );
  }
}
