import 'package:flutter/material.dart';
import 'package:torneios_app/src/widgets/form_dialog.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('TORNEIOS'),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: TournamentCard(tournament: tournament),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const FormDialog();
            },
          )
        },
        label: const Text("Novo"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
