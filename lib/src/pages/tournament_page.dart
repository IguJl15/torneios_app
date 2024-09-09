import 'package:flutter/material.dart';
import 'package:torneios_app/src/models/tournament.dart';
import 'package:torneios_app/src/pages/location_page.dart';
import 'package:torneios_app/src/pages/teams_page.dart';
import 'package:torneios_app/src/widgets/tournament_list_item.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({super.key, required this.tournament});
  final Tournament tournament;

  static const itens = [
    TournamentListItem(
      text: "Equipes",
      icon: Icons.groups,
      page: TeamsPage(),
      route: '/equipes',
    ),
    TournamentListItem(
      text: "Rodadas",
      icon: Icons.web,
      page: TeamsPage(),
      route: '/rodadas',
    ),
    TournamentListItem(
      text: "Localização",
      icon: Icons.location_on,
      page: LocationPage(),
      route: '/location ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tournament.name),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: itens.length,
        padding: const EdgeInsets.all(5),
        itemBuilder: (BuildContext context, int index) {
          final Widget item = itens[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: item,
          );
        },
      ),
    );
  }
}
