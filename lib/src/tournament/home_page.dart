import 'package:flutter/material.dart';

class Tournament { 
  final String name;
  final String description;
  final List<String> teams;

final tournaments = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Torneios')),
      body: ListView.builder(
        
        itemBuilder: (context, index) {
          final tournament = tournaments[index];

          return ListTile(
            title: Text(tournament.name),
            subtitle: Text(tournament.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TournamentPage(),
                  settings: const RouteSettings(name: '/tournament'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TournamentPage extends StatelessWidget {
  const TournamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
