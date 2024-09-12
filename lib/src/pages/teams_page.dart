import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:torneios_app/main.dart';
import 'package:torneios_app/src/models/team.dart';
import 'package:torneios_app/src/models/tournament.dart';
import 'package:torneios_app/src/shared/utils.dart';
import 'package:torneios_app/src/widgets/team_bottom_bar.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({required this.tournament, super.key});

  final Tournament tournament;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final _newTeamTextController = TextEditingController();
  final inputFocusNode = FocusNode();

  int _teamQuantity = 32;

  @override
  void initState() {
    super.initState();

    if (widget.tournament.teams.isNotEmpty && isPowerOfTwo(widget.tournament.teams.length)) {
      _teamQuantity = widget.tournament.teams.length;
    }
  }

  @override
  void dispose() {
    _newTeamTextController.dispose();
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);

    final babColor = switch (MediaQuery.platformBrightnessOf(context)) {
      Brightness.light => theme.colorScheme.secondaryContainer,
      Brightness.dark => Color.alphaBlend(
          theme.colorScheme.surface.withOpacity(0.5),
          theme.colorScheme.secondaryContainer,
        ),
    };

    return PopScope(
      canPop: widget.tournament.teams.length == _teamQuantity,
      onPopInvoked: (didPop) {
        if (!didPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Ainda há equipes não definidas"),
            ),
          );
        }
      },
      child: ValueListenableBuilder(
        valueListenable: Hive.box<Team>(teamsBox).listenable(),
        builder: (context, Box<Team> teamBox, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Equipes"),
              centerTitle: true,
              shape: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48 + 4 + 4),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DropdownButtonFormField<int>(
                    value: _teamQuantity,
                    items: List.generate(
                      5,
                      (index) {
                        final qtd = pow(2, index + 1).toInt();
                        return DropdownMenuItem(value: qtd, child: Text("$qtd equipes"));
                      },
                    ),
                    onChanged: widget.tournament.isActive ? null : changeTotalTeamsQuantity,
                    decoration: const InputDecoration(
                      labelText: "Quantidade de equipes",
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: babColor,
              height: 96 + viewInsets.bottom,
              elevation: 0,
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12.0 + viewInsets.bottom),
              child: InfoInput(
                controller: _newTeamTextController,
                focusNode: inputFocusNode,
                enabled: !widget.tournament.isActive &&
                    widget.tournament.teams.length < _teamQuantity,
                addItemButtonPressed: () async {
                  final team = Team(name: _newTeamTextController.text);
                  await teamBox.add(team);

                  widget.tournament.teams.add(team);
                  widget.tournament.save();

                  _newTeamTextController.clear();
                },
              ),
            ),
            body: ListView.builder(
              itemCount: _teamQuantity,
              itemBuilder: (context, index) {
                if (index < widget.tournament.teams.length) {
                  final team = widget.tournament.teams[index];
                  return ListTile(
                    title: Text(team.name),
                    leading: CircleAvatar(child: Text("${index + 1}")),
                  );
                }

                return ListTile(
                  enabled: false,
                  title: const Text("Equipe não definida"),
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.outlineVariant,
                    child: Text("${index + 1}"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void changeTotalTeamsQuantity(int? value) {
    if (value == null) return;

    void updateTeamQuantity(int value) async {
      setState(() {
        _teamQuantity = value;
      });

      if (value < widget.tournament.teams.length) {
        widget.tournament.teams.removeRange(value, widget.tournament.teams.length);
        await widget.tournament.save();
      }

      print("Quantidade de equipes: ${widget.tournament.teams.length}");
    }

    if (value >= widget.tournament.teams.length) {
      updateTeamQuantity(value);
    } else {
      // Show dialog adverting about losing teams

      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Atenção"),
            content: const Text(
                "Você está prestes a perder equipes. Tem certeza que deseja continuar?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateTeamQuantity(widget.tournament.teams.length);
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateTeamQuantity(value);
                },
                child: const Text("Continuar"),
              ),
            ],
          );
        },
      );
    }
  }
}
