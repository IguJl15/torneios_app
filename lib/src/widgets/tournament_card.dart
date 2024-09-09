import 'package:flutter/material.dart';
import 'package:torneios_app/src/models/tournament.dart';
import 'package:torneios_app/src/pages/tournament_page.dart';

class TournamentCard extends StatefulWidget {
  final Tournament tournament; // Declare the tournament variable

  const TournamentCard({super.key, required this.tournament}); // Initialize it in the constructor

  @override
  State<TournamentCard> createState() => _TournamentCardState();
}

class _TournamentCardState extends State<TournamentCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(widget.tournament.name), // Access the tournament object with widget.tournament
      subtitle: Text(widget.tournament.description), // Same here
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TournamentPage(tournament: widget.tournament), // Pass the tournament to TournamentPage
            settings: const RouteSettings(name: '/tournament'),
          ),
        );
      },
    );
  }
}

