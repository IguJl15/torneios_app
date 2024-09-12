import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torneios_app/src/models/round.dart';
import '../models/match.dart';
import '../models/team.dart';
import '../models/tournament.dart';

class RoundsPage extends StatefulWidget {
  const RoundsPage({super.key, required this.tournament});

  final Tournament tournament;

  @override
  State<RoundsPage> createState() => _RoundsPageState();
}

class _RoundsPageState extends State<RoundsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.tournament.rounds.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Rodadas')),
        body: Center(
          child: Text("O torneio ainda não foi iniciado", style: theme.textTheme.titleLarge),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rodadas'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: DefaultTextStyle.merge(
            style: theme.textTheme.titleLarge,
            child: Row(
              children: [
                const Text("Equipe vencedora: "),
                Text(widget.tournament.winner?.name ?? "Não definida")
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.tournament.rounds.length,
        itemBuilder: (context, index) {
          final round = widget.tournament.rounds[index];

          final isLastRound = index == widget.tournament.rounds.length - 1;
          final belowRound = isLastRound ? null : widget.tournament.rounds[index + 1];

          // can edit starting from the last round. When last round is finished, the
          // next will be available to edit
          final canEditRound = isLastRound || belowRound?.locked == true;

          final teams = isLastRound ? widget.tournament.teams : belowRound!.winners;

          return Card.filled(
            elevation: 2,
            color: theme.colorScheme.surfaceContainerLow,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "Rodada ${round.index} ${!canEditRound ? '(Bloqueado)' : ''}",
                      style: theme.textTheme.titleLarge,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: canEditRound && (round.locked != true)
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  round.lock();
                                });
                              },
                              child: const Text("Finalizar"),
                            )
                          : const Text("Finalizado"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: round.matches.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 46,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final match = round.matches[index];
                      onSave(match) {
                        setState(() {});
                      }

                      return Card(
                        elevation: 1,
                        color: Colors.amber[100],
                        child: InkWell(
                          onTap: !canEditRound || round.locked == true
                              ? null
                              : () {
                                  showAdaptiveDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return EditMatchForm(
                                        teams: teams,
                                        round: round,
                                        match: match,
                                        onSave: onSave,
                                      );
                                    },
                                  );
                                },
                          child: !match.isValid
                              ? Center(
                                  child: Text(
                                    "Disputa",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: DefaultTextStyle.merge(
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(height: 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(child: Text(match.team1?.name ?? "")),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${match.score1} - ${match.score2}",
                                          style: const TextStyle(fontFamily: "monospace"),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(child: Text(match.team2?.name ?? "")),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditMatchForm extends StatefulWidget {
  const EditMatchForm(
      {super.key,
      required this.match,
      required this.onSave,
      required this.teams,
      required this.round});

  final List<Team> teams;
  final Round round;
  final Match match;
  final Function(Match) onSave;

  @override
  State<EditMatchForm> createState() => _EditMatchFormState();
}

class _EditMatchFormState extends State<EditMatchForm> {
  final _formKey = GlobalKey<FormState>();
  Team? _team1;
  Team? _team2;
  final _score1Controller = TextEditingController(text: "0");
  final _score2Controller = TextEditingController(text: "0");

  String? _error;

  @override
  void initState() {
    super.initState();

    _team1 = widget.match.team1;
    _team2 = widget.match.team2;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: theme.colorScheme.surface,
    );

    final teams = widget.teams.where(
      (team) {
        final allTeamsOnValidMatches = widget.round.matches
            .where((match) => match.isValid) //
            .where((match) => match != widget.match) //
            .fold<Set<Team>>(
          <Team>{},
          (allTeamsThisMatch, element) =>
              allTeamsThisMatch..addAll([element.team1!, element.team2!]),
        );

        return !allTeamsOnValidMatches.contains(team);
      },
    );

    return AlertDialog.adaptive(
      title: const Text("Disputa"),
      scrollable: true,
      contentPadding: const EdgeInsets.all(12),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() == true) {
              final score1 = int.parse(_score1Controller.text);
              final score2 = int.parse(_score2Controller.text);

              if (score1 == score2) {
                return setState(() {
                  _error = "As pontuações devem ser diferentes";
                });
              }

              widget.match.team1 = _team1;
              widget.match.team2 = _team2;
              widget.match.score1 = int.parse(_score1Controller.text);
              widget.match.score2 = int.parse(_score2Controller.text);

              await widget.match.save();

              widget.onSave(widget.match);

              if (context.mounted) Navigator.pop(context);
            }
          },
          child: const Text("Salvar"),
        ),
      ],
      content: SizedBox(
        width: 450,
        child: Card.filled(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: theme.colorScheme.surfaceContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DefaultTextStyle(
                      style: theme.textTheme.titleMedium!.copyWith(
                        height: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      child: const Row(children: [
                        Expanded(flex: 3, child: Center(child: Text("Times"))),
                        Expanded(flex: 1, child: Center(child: Text("Pontos"))),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                              value: _team1,
                              isExpanded: true,
                              decoration: inputDecoration,
                              alignment: Alignment.centerRight,
                              validator: (value) {
                                if (value == null) return "Selecione uma equipe";
                                if (value == _team2) return "As equipes não podem ser iguais";

                                return null;
                              },
                              items: [
                                const DropdownMenuItem(value: null, child: Text("Escolha")),
                                ...teams.map((t) => assembleDropdownItem(t, t != _team2)),
                              ],
                              onChanged: (value) => setState(() => _team1 = value),
                            ),
                          ),
                          const SizedBox.square(dimension: 8),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _score1Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                if (value == null) return null;
                                if (value.isEmpty) return "Insira o número de pontos";
                                if (int.tryParse(value) == null)
                                  return "Insira um número válido";

                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const Row(children: [
                      Expanded(flex: 5, child: Divider()),
                      Expanded(flex: 1, child: Text("VS", textAlign: TextAlign.center)),
                      Expanded(flex: 5, child: Divider())
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                              value: _team2,
                              isExpanded: true,
                              alignment: Alignment.centerRight,
                              decoration: inputDecoration,
                              validator: (value) {
                                if (value == null) return "Selecione uma equipe";
                                if (value == _team1) return "As equipes não podem ser iguais";

                                return null;
                              },
                              items: [
                                const DropdownMenuItem(value: null, child: Text("Escolha")),
                                ...teams.map((t) => assembleDropdownItem(t, t != _team1)),
                              ],
                              onChanged: (value) => setState(() => _team2 = value),
                            ),
                          ),
                          const SizedBox.square(dimension: 8),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _score2Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: inputDecoration,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                if (value == null) return null;
                                if (value.isEmpty) return "Insira o número de pontos";
                                if (int.tryParse(value) == null)
                                  return "Insira um número válido";

                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_error != null)
                      Text(
                        _error!,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.error),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<Team> assembleDropdownItem(Team t, bool enabled) => DropdownMenuItem(
        value: t,
        enabled: enabled,
        child: Text(t.name),
      );
}
