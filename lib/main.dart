import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'hive_registrar.g.dart';
import 'src/app.dart';
import 'src/models/match.dart';
import 'src/models/round.dart';
import 'src/models/team.dart';
import 'src/models/tournament.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

const tournamentsBox = 'tournaments';
const teamsBox = 'teams';
const roundsBox = 'rounds';
const matchesBox = 'matches';

final faker = Faker();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseKey,
  );

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  final dbDirectory = await getApplicationSupportDirectory();

  Hive
    ..init(dbDirectory.path)
    ..registerAdapters();

  await Hive.openBox<Tournament>(tournamentsBox);
  await Hive.openBox<Team>(teamsBox);
  await Hive.openBox<Round>(roundsBox);
  await Hive.openBox<Match>(matchesBox);

  runApp(MyApp(settingsController: settingsController));
}

abstract class Environment {
  static const String supabaseUrl = 'https://foo.supabase.co/';
  static const String supabaseKey = 'you anon key';
}
