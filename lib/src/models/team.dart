import 'package:hive_ce/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 1)
class Team extends HiveObject {
  @HiveField(0)
  final String name;

  Team({
    required this.name,
  });

  @override
  String toString() {
    return 'Team(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (other is! Team) return false;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
