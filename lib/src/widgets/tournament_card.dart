import 'package:flutter/material.dart';
import 'package:torneios_app/src/models/tournament.dart';
import 'package:torneios_app/src/pages/tournament_page.dart';

class TournamentCard extends StatefulWidget {
  final Tournament tournament;

  // Initialize it in the constructor
  const TournamentCard({super.key, required this.tournament});

  @override
  State<TournamentCard> createState() => _TournamentCardState();
}

class _TournamentCardState extends State<TournamentCard> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.all(2),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: CircleAvatar(
          foregroundImage: NetworkImage(widget.tournament.imagePath),
        ),
        // Access the tournament object with widget.tournament
        title: Text(widget.tournament.name),
        subtitle: Text(widget.tournament.description), // Same here
        onLongPress: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text("Deletar torneio"),
                content: const Text("Tem certeza que deseja deletar este torneio?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await widget.tournament.delete();
                      if (dialogContext.mounted) Navigator.pop(dialogContext);
                    },
                    child: const Text("Deletar"),
                  ),
                ],
              );
            },
          );
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // Pass the tournament to TournamentPage
              builder: (context) => TournamentPage(tournament: widget.tournament),
              settings: const RouteSettings(name: '/tournament'),
            ),
          );
        },
      ),
    );
  }
}
