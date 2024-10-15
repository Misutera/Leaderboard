import 'package:json_annotation/json_annotation.dart';

part 'classes.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String avatar;
  final String? country = null;
  int qualifierScore;
  List<Score>? score;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    this.qualifierScore = 0,
    this.score,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Score {
  final String id;
  final String hash;
  final String difficulty;
  final String mode;
  final int score;
  final Song songData;

  Score({
    required this.id,
    required this.hash,
    required this.difficulty,
    required this.mode,
    required this.score,
    required this.songData,
  });
  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}

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
