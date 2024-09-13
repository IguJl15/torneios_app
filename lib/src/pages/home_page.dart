import 'package:flutter/material.dart';
import 'package:flutter_map_location_picker/flutter_map_location_picker.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../models/round.dart';
import '../models/team.dart';
import '../models/tournament.dart';
import '../widgets/tournament_card.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: Hive.box<Tournament>(tournamentsBox).listenable(),
      builder: (context, Box<Tournament> box, widget) {
        final tournaments = box.values.toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('TORNEIOS'),
            centerTitle: true,
            elevation: 1,
            shape: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text("Sair"),
                        content: const Text("Deseja sair do aplicativo?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await Supabase.instance.client.auth.signOut();

                              if (dialogContext.mounted) Navigator.pop(dialogContext);
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                  (route) => false,
                                );
                              }
                            },
                            child: const Text("Sair"),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
          body: tournaments.isEmpty
              ? Center(
                  child: Text(
                    "Crie um torneio para começar",
                    style: theme.textTheme.headlineSmall,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: tournaments.length,
                  itemBuilder: (context, index) {
                    final tournament = tournaments[index];
                    return TournamentCard(tournament: tournament);
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return const SimpleDialog(
                    title: Text("Novo torneio"),
                    children: [
                      CreateTournamentForm(),
                    ],
                  );
                },
              );
            },
            label: const Text("Novo"),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class CreateTournamentForm extends StatefulWidget {
  const CreateTournamentForm({super.key});

  @override
  State<CreateTournamentForm> createState() => _CreateTournamentFormState();
}

class _CreateTournamentFormState extends State<CreateTournamentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _locationFieldKey = GlobalKey<FormFieldState<LocationResult?>>();
  final _locationTextController = TextEditingController();

  Future<void> createButtonPressed(BuildContext context) async {
    await Future.delayed(Duration.zero);

    if (_formKey.currentState?.validate() == false) {
      return;
    }

    final name = _nameTextController.text;
    final location = _locationFieldKey.currentState?.value;

    if (name.isEmpty || location == null) {
      return;
    }

    final box = Hive.box<Tournament>(tournamentsBox);
    final teamBox = Hive.box<Team>(teamsBox);
    final roundBox = Hive.box<Round>(roundsBox);

    box.add(
      Tournament(
        id: const Uuid().v4(),
        name: _nameTextController.text,
        description: _descriptionTextController.text,
        imagePath: faker.image.loremPicsum(),
        isActive: false,
        rounds: HiveList(roundBox),
        teams: HiveList(teamBox),
        address: _locationTextController.text,
        geolocation:
            "${_locationFieldKey.currentState?.value?.latitude} ${_locationFieldKey.currentState?.value?.longitude}",
      ),
    );

    Navigator.pop(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameTextController,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      hintText: "Nome do torneio",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira o nome do torneio";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTextController,
                    decoration: const InputDecoration(
                      labelText: "Descrição",
                      hintText: "Descrição do torneio",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira a descrição do torneio";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  FormField<LocationResult?>(
                    key: _locationFieldKey,
                    builder: (field) {
                      return TextField(
                        readOnly: true,
                        controller: _locationTextController,
                        decoration: InputDecoration(
                          labelText: "Localização",
                          hintText: "Localização do torneio",
                          errorText: field.errorText,
                        ),
                        onTap: () async {
                          final geocoding = await Navigator.push<LocationResult>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: MapLocationPicker(
                                  initialZoom: 10,
                                  initialLatitude: -5.08917,
                                  initialLongitude: -42.80194,
                                  onPicked: (pickedData) {
                                    Navigator.pop<LocationResult>(context, pickedData);
                                  },
                                ),
                              ),
                            ),
                          );

                          if (geocoding != null) {
                            setState(() {
                              field.didChange(geocoding);
                              _locationTextController.text =
                                  geocoding.completeAddress ?? geocoding.locationName ?? '';
                              if (_locationTextController.text.trim().isEmpty) {
                                _locationTextController.text = "Localização sem endereço";
                              }
                            });
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                FilledButton(
                  onPressed: () => createButtonPressed(context),
                  child: const Text("Criar"),
                ),
              ],
            ),
          ],
        ));
  }
}
