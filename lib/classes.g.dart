// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      qualifierScore: (json['qualifierScore'] as num?)?.toInt() ?? 0,
      score: (json['score'] as List<dynamic>?)
          ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'qualifierScore': instance.qualifierScore,
      'score': instance.score,
    };

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
      id: json['id'] as String,
      hash: json['hash'] as String,
      difficulty: json['difficulty'] as String,
      mode: json['mode'] as String,
      score: (json['score'] as num).toInt(),
      songData: Song.fromJson(json['songData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'difficulty': instance.difficulty,
      'mode': instance.mode,
      'score': instance.score,
      'songData': instance.songData,
    };

Qualifier _$QualifierFromJson(Map<String, dynamic> json) => Qualifier(
      mapID: json['mapID'] as String,
      mapDifficulty: json['mapDifficulty'] as String,
      mapMode: json['mapMode'] as String,
      mapBSR: json['mapBSR'] as String?,
    );

Map<String, dynamic> _$QualifierToJson(Qualifier instance) => <String, dynamic>{
      'mapID': instance.mapID,
      'mapDifficulty': instance.mapDifficulty,
      'mapMode': instance.mapMode,
      'mapBSR': instance.mapBSR,
    };

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['id'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      mapper: json['mapper'] as String,
      coverImage: json['coverImage'] as String,
      hash: json['hash'] as String,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'mapper': instance.mapper,
      'coverImage': instance.coverImage,
      'hash': instance.hash,
    };
