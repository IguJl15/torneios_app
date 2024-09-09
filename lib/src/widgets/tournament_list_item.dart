import 'package:flutter/material.dart';

class TournamentListItem extends StatefulWidget {
  final String text;
  final IconData icon;
  final Widget page;
  final String route;

  const TournamentListItem({
    super.key,
    required this.text,
    required this.icon,
    required this.page,
    required this.route,
  });

  @override
  State<TournamentListItem> createState() => _TournamentListItemState();
}

class _TournamentListItemState extends State<TournamentListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(widget.text),
      leading: Icon(widget.icon),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.page,
            settings: RouteSettings(
              name: widget.route,
            ),
          ),
        );
      },
    );
  }
}
