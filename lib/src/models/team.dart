import 'package:hive_ce/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 1)
class Team extends HiveObject {
  @HiveField(0)
  final String name;

  Team({
    required this.name,
  });
}
