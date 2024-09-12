import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

import 'package:path_provider/path_provider.dart';
import 'package:torneios_app/hive_registrar.g.dart';
import 'package:torneios_app/src/models/tournament.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

var tournamentsBox = 'tournaments';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  final dbDirectory = await getApplicationSupportDirectory();

  Hive
    ..init(dbDirectory.path)
    ..registerAdapters();
  await Hive.openBox<Tournament>(tournamentsBox);
  runApp(MyApp(settingsController: settingsController));
}
