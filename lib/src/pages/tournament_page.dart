import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(tournament.name),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
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
            pageBuilder: (_) => TeamsPage(tournament: tournament),
            route: '/rodadas',
          ),
          TournamentListItem(
            text: "Localização",
            icon: Icons.location_on,
            pageBuilder: (_) => TeamsPage(tournament: tournament),
            route: '/location ',
          ),
        ],
      ),
    );
  }
}
