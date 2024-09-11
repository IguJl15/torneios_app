import 'package:flutter/material.dart';
// import 'package:torneios_app/src/widgets/form_dialog.dart';
import 'package:torneios_app/src/widgets/tournament_card.dart';
import '../models/tournament.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Tournament> tournaments = [
    Tournament("Lorem", "Welcome to my tournament"),
    Tournament("Lorem", "Welcome to my tournament"),
    Tournament("Lorem", "Welcome to my tournament"),
    Tournament("Lorem", "Welcome to my tournament"),
    Tournament("Lorem", "Welcome to my tournament"),
    Tournament("Lorem", "Welcome to my tournament"),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        onPressed: () {},
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return const FormDialog();
        //   },
        // )

        label: const Text("Novo"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
