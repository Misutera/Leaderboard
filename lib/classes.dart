import 'package:json_annotation/json_annotation.dart';

part 'classes.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String avatar;
  final String? country = null;
  int qualifierScore;
  //final List<Score>? score;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    //this.score,
    this.qualifierScore = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// This thing is not implemented yet. Might delete if it's completely useless.
// This is to get detailed score data on specific map for each player. instead of just showing the total score amount
@JsonSerializable()
class Score {
  final String hash;
  final String difficulty;
  final String mode;
  final int score;

  Score({
    required this.hash,
    required this.difficulty,
    required this.mode,
    required this.score,
  });
  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}
// ==========================================================================

@JsonSerializable()
class Qualifier {
  final String mapID;
  final String mapDifficulty;
  final String mapMode;
  final String? mapBSR;

  Qualifier({
    required this.mapID,
    required this.mapDifficulty,
    required this.mapMode,
    this.mapBSR,
  });
}

@JsonSerializable()
class Song {
  final String id;
  final String name;
  //final String? subname;
  final String author;
  final String mapper;
  final String coverImage;
  final String hash;

  Song({
    required this.id,
    required this.name,
    //this.subname = '',
    required this.author,
    required this.mapper,
    required this.coverImage,
    required this.hash,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);
}
